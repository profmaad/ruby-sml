require 'sml-time'

module SML
  module PublicOpen

    class Request
      attr_accessor :codepage, :client_id, :request_file_id, :server_id, :username, :password, :sml_version

      def initialize(codepage, client_id, request_file_id, server_id, username, password, sml_version)
        @codepage = codepage
        @client_id = client_id
        @request_file_id = request_file_id
        @server_id = server_id
        @username = username
        @password = password
        @sml_version = sml_version
      end

      def self.construct(array_rep)
        codepage = array_rep.shift.to_s
        client_id = array_rep.shift.to_s
        request_file_id = array_rep.shift.to_s
        server_id = array_rep.shift.to_s
        username = array_rep.shift.to_s
        password = array_rep.shift.to_s
        sml_version = array_rep.shift.to_i

        return SML::PublicOpen::Request.new(codepage, client_id, request_file_id, server_id, username, password, sml_version)
      end
      
    end

    class Response
      attr_accessor :codepage, :client_id, :request_file_id, :server_id, :reference_time, :sml_version

      def initialize(codepage, client_id, request_file_id, server_id, reference_time, sml_version)
        @codepage = codepage
        @client_id = client_id
        @request_file_id = request_file_id
        @server_id = server_id
        @reference_time = reference_time
        @sml_version = sml_version
      end

      def self.construct(array_rep)
        codepage = array_rep.shift.to_s
        client_id = array_rep.shift.to_s
        request_file_id = array_rep.shift.to_s
        server_id = array_rep.shift.to_s
        reference_time = SML::Time.construct(array_rep.shift)
        sml_version = array_rep.shift.to_i

        return nil if reference_time.nil?
        return SML::PublicOpen::Response.new(codepage, client_id, request_file_id, server_id, reference_time, sml_version)
      end

    end

  end
end
