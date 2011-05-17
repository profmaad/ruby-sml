require 'nilclass-mixin'
require 'sml-tree'

module SML
  module Attention
    
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
