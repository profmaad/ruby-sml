module SML
  module PublicClose

    class Request
      attr_accessor :global_signature

      def initialize(global_signature)
        @global_signature = global_signature
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        return SML::PublicClose::Request.new(array_rep.shift)
      end

    end
    
    class Response
      attr_accessor :global_signature

      def initialize(global_signature)
        @global_signature = global_signature
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        return SML::PublicClose::Response.new(array_rep.shift)
      end

    end

  end
end
