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
      transaction_id = array_rep.shift.to_s
      group_no = array_rep.shift.to_i
      abort_on_error_code = array_rep.shift.to_i
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
      checksum = array_rep.shift.to_i
      
      return SML::Message.new(transaction_id, group_no, abort_on_error, body, checksum)
    end

  end

end
