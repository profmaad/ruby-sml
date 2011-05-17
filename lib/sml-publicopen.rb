require 'nilclass-mixin'
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
        return nil if array_rep.nil?
        codepage = array_rep.shift
        client_id = array_rep.shift
        request_file_id = array_rep.shift
        server_id = array_rep.shift
        username = array_rep.shift
        password = array_rep.shift
        sml_version = array_rep.shift

        return SML::PublicOpen::Request.new(codepage, client_id, request_file_id, server_id, username, password, sml_version)
      end
      def to_a
        return [] << codepage << client_id << request_file_id << server_id << username << password << sml_version
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
        return nil if array_rep.nil?
        codepage = array_rep.shift
        client_id = array_rep.shift
        request_file_id = array_rep.shift
        server_id = array_rep.shift
        reference_time = SML::Time.construct(array_rep.shift)
        sml_version = array_rep.shift

        return nil if reference_time.nil?
        return SML::PublicOpen::Response.new(codepage, client_id, request_file_id, server_id, reference_time, sml_version)
      end
      def to_a
         return [] << codepage << client_id << request_file_id << server_id << reference_time.to_a << sml_version
      end

    end

  end
end
