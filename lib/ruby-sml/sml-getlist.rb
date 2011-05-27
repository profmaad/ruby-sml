require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-tree'
require 'ruby-sml/sml-listentry'
require 'ruby-sml/sml-time'

module SML
  module GetList

    class Request
      attr_accessor :client_id, :server_id, :username, :password, :list_name

      def initialize(client_id, server_id, username, password, list_name)
        @client_id = client_id
        @server_id = server_id
        @username = username
        @password = password
        @list_name = list_name
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        client_id = array_rep.shift
        server_id = array_rep.shift
        username = array_rep.shift
        password = array_rep.shift
        list_name = array_rep.shift

        return SML::GetList::Request.new(client_id, server_id, username, password, list_name)
      end
      def to_a
        return [] << client_id << server_id << username << password << list_name
      end

    end

    class Response
      attr_accessor :client_id, :server_id, :list_name, :act_sensor_time, :value_list, :list_signature, :act_gateway_time

      def initialize(client_id, server_id, list_name, act_sensor_time, value_list, list_signature, act_gateway_time)
        @client_id = client_id
        @server_id = server_id
        @list_name = list_name
        @act_sensor_time = act_sensor_time
        @value_list = value_list
        @list_signature = list_signature
        @act_gateway_time = act_gateway_time
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        client_id = array_rep.shift
        server_id = array_rep.shift
        list_name = array_rep.shift
        act_sensor_time = SML::Time.construct(array_rep.shift)
        value_list = []
        array_rep.shift.each do |entry_array_rep|
          entry = SML::ListEntry.construct(entry_array_rep)
          return nil if entry.nil?
          value_list << entry
        end
        list_signature = array_rep.shift
        act_gateway_time = SML::Time.construct(array_rep.shift)

        return SML::GetList::Response.new(client_id, server_id, list_name, act_sensor_time, value_list, list_signature, act_gateway_time)
      end
      def to_a
        value_list_array = []
        value_list.each do |value|
          value_list_array << value.to_a
        end

        return [] << client_id << server_id << list_name << act_sensor_time.to_a << value_list_array << list_signature << act_gateway_time.to_a
      end

    end

  end
end
