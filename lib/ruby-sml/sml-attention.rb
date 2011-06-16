require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-tree'

module SML
  module Attention

    Errors = {}
    Errors["\x81\x81\xc7\xc7\xfe\x00"] = "unknown error"
    Errors["\x81\x81\xc7\xc7\xfe\x01"] = "unknown SML identifier"
    Errors["\x81\x81\xc7\xc7\xfe\x02"] = "insufficient authentification, user/password invalid"
    Errors["\x81\x81\xc7\xc7\xfe\x03"] = "target address (serverId) not available"
    Errors["\x81\x81\xc7\xc7\xfe\x04"] = "request (reqFileId) not available"
    Errors["\x81\x81\xc7\xc7\xfe\x05"] = "one or more target attributes could not be written"
    Errors["\x81\x81\xc7\xc7\xfe\x06"] = "one or more target attributes could not be read"
    Errors["\x81\x81\xc7\xc7\xfe\x07"] = "communication with metering point interrupted"
    Errors["\x81\x81\xc7\xc7\xfe\x08"] = "raw data could not be interpreted"
    Errors["\x81\x81\xc7\xc7\xfe\x09"] = "value out of range"
    Errors["\x81\x81\xc7\xc7\xfe\x0a"] = "request not executed"
    Errors["\x81\x81\xc7\xc7\xfe\x0b"] = "checksum incorrect"
    Errors["\x81\x81\xc7\xc7\xfe\x0c"] = "broadcast not supported"
    Errors["\x81\x81\xc7\xc7\xfe\x0d"] = "unexpected SML message"
    Errors["\x81\x81\xc7\xc7\xfe\x0e"] = "unknown object in load curve"
    Errors["\x81\x81\xc7\xc7\xfe\x0f"] = "unsupported data type in SetProcPar"
    Errors["\x81\x81\xc7\xc7\xfe\x10"] = "optional element not supported"
    Errors["\x81\x81\xc7\xc7\xfe\x11"] = "profile doesn't have any entries"
    Errors["\x81\x81\xc7\xc7\xfe\x12"] = "end before begin"
    Errors["\x81\x81\xc7\xc7\xfe\x13"] = "no entries in time frame"
    Errors["\x81\x81\xc7\xc7\xfe\x14"] = "SML-Close missing"
    
    Errors["\x81\x81\xc7\xc7\xfd\x00"] = "ok"
    Errors["\x81\x81\xc7\xc7\xfd\x01"] = "execution delayed, response will be delivered via response-without-request"
    
    
    class Response
      attr_accessor :server_id, :number, :message, :details

      def initialize(server_id, number, message, details)
        @server_id = server_id
        @number = number
        @message = message
        @details = details
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        server_id = array_rep.shift
        number = array_rep.shift
        message = array_rep.shift
        details = SML::Tree.construct(array_rep.shift)

        return SML::Attention::Response.new(server_id, number, message, details)
      end
      def to_a
       return [] << server_id << number << message < details.to_a
      end

    end

  end
end
