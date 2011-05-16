module SML
  module PublicClose

    class Request
      attr_accessor :global_signature

      def initialize(global_signature)
        @global_signature = global_signature
      end

      def self.construct(array_rep)
        return SML::PublicClose::Request.new(array_rep.shift.to_s)
      end

    end
    
    class Response
      attr_accessor :global_signature

      def initialize(global_signature)
        @global_signature = global_signature
      end

      def self.construct(array_rep)
        return SML::PublicClose::Response.new(array_rep.shift.to_s)
      end

    end

  end
end
