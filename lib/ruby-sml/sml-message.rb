require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-messagebody'

require 'ruby-sml/encoding-binary'

module SML

  class Message
    attr_accessor :transaction_id, :group_no, :abort_on_error, :body, :checksum

    def initialize(transaction_id, group_no, abort_on_error, body, checksum)
      @transaction_id = transaction_id
      @group_no = group_no
      @abort_on_error = abort_on_error
      @body = body
      @checksum = checksum
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      transaction_id = array_rep.shift
      group_no = array_rep.shift
      array_rep.shift unless group_no.nil?
      abort_on_error_code = array_rep.shift
      array_rep.shift unless abort_on_error_code.nil?
      abort_on_error = nil
      abort_on_error = case abort_on_error_code
                       when 0x00
                         :continue
                       when 0x01
                         :continue_with_next_group
                       when 0x02
                         :finish_group
                       when 0xff
                         :abort
                       end
      body = SML::MessageBody.construct(array_rep.shift)
      return nil if body.nil?
      checksum = array_rep.shift
      array_rep.shift unless checksum.nil?

      return nil unless array_rep.shift == :end_of_message
      return SML::Message.new(transaction_id, group_no, abort_on_error, body, checksum)
    end

    def self.pconstruct(o={})
      return SML::Message.new(o[:transaction_id], o[:group_no], o[:abord_on_error], o[:body], o[:checksum])
    end

    def to_a
      calculate_checksum
      return to_a_internal
    end

    def to_a_internal
      abort_on_error_code = case abort_on_error
                            when :continue
                              0x00
                            when :continue_with_next_group
                              0x01
                            when :finish_group
                              0x02
                            when :abort
                              0xff
                            end
      
      result = [] << transaction_id << group_no
      result << :uint8 unless group_no.nil?
      result << abort_on_error_code
      result << :uint8 unless abort_on_error_code.nil?
      result << SML::MessageBody.to_a(body) << checksum
      result << :uint16 unless checksum.nil?
      return result << :end_of_message
    end

    def calculate_checksum
      encoded = SML::BinaryEncoding.encode_value(self.to_a_internal, :array)
      encoded.slice!(-3,3)
      calculated_checksum = CRC16.crc16(encoded)
      calculated_checksum = (calculated_checksum ^ 0xffff)
      calculated_checksum = ((calculated_checksum & 0xff00) >> 8) | ((calculated_checksum & 0x00ff) << 8)
      @checksum = calculated_checksum   
    end

  end

end
