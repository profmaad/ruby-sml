require 'nilclass-mixin'
require 'sml-messagebody'

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
      abort_on_error_code = array_rep.shift
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

      return nil unless array_rep.shift == :end_of_message
      return SML::Message.new(transaction_id, group_no, abort_on_error, body, checksum)
    end
    def to_a
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
      
      return [] << transaction_id << group_no << abort_on_error_code << SML::MessageBody.to_a(body) << checksum << :end_of_message
    end

  end

end
