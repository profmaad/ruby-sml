require 'nilclass-mixin'
require 'sml-time'
require 'sml-treepath'
require 'sml-tree'
require 'sml-profileobjectheaderentry'
require 'sml-profileobjectperiodentry'

module SML
  module GetProfilePack

    class Request
      attr_accessor :server_id, :username, :password, :with_raw_data, :begin_time, :end_time, :parameter_treepath, :object_list, :das_details

      def initialize(server_id, username, password, with_raw_data, begin_time, end_time, parameter_treepath, object_list, das_details)
        @server_id = server_id
        @username = username
        @password = password
        @with_raw_data = with_raw_data
        @begin_time = begin_time
        @end_time = end_time
        @parameter_treepath = parameter_treepath
        @object_list = object_list
        @das_details = das_details
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        server_id = array_rep.shift
        username = array_rep.shift
        password = array_rep.shift
        with_raw_data = array_rep.shift
        begin_time = SML::Time.construct(array_rep.shift)
        end_time = SML::Time.construct(array_rep.shift)
        parameter_treepath = SML::Treepath.construct(array_rep.shift)
        object_list = array_rep.shift
        das_details = SML::Tree.construct(array_rep.shift)

        return nil if parameter_treepath.nil?
        return SML::GetProfilePack::Request.new(server_id, username, password, with_raw_data, begin_time, end_time, parameter_treepath, object_list, das_details)
      end
      def to_a
        return [] << server_id << username << password << with_raw_data << begin_time.to_a << end_time.to_a << parameter_treepath.to_a << object_list << das_details.to_a
      end

    end

    class Response
      attr_accessor :server_id, :act_time, :register_period, :parameter_treepath, :header_list, :period_list, :raw_data, :profile_signature
      
      def initialize(server_id, act_time, register_period, parameter_treepath, header_list, period_list, raw_data, profile_signature)
        @server_id = server_id
        @act_time = act_time
        @register_period = register_period
        @parameter_treepath = parameter_treepath
        @header_list = header_list
        @period_list = period_list
        @raw_data = raw_data
        @profile_signature = profile_signature
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        server_id = array_rep.shift
        act_time = SML::Time.construct(array_rep.shift)
        registration_period = array_rep.shift
        parameter_treepath = SML::Treepath.construct(array_rep.shift)
        header_list = []
        array_rep.shift.each do |entry_array_rep|
          entry = SML::ProfileObjectHeaderEntry.construct(entry_array_rep)
          return nil if entry.nil?
          header_list << entry
        end
        period_list = []
        array_rep.shift.each do |entry_array_rep|
          entry = SML::ProfileObjectPeriodEntry.construct(entry_array_rep)
          return nil if entry.nil?
          period_list << entry
        end
        raw_data = array_rep.shift
        profile_signature = array_rep.shift

        return nil if (act_time.nil? or parameter_treepath.nil?)
        return SML::GetProfilePack::Response.new(server_id, act_time, registration_period, parameter_treepath, header_list, period_list, raw_data, profile_signature)
      end
      def to_a
        header_list_array = []
        header_list.each do |entry|
          header_list_array << entry.to_a
        end
        period_list_array = []
        period_list.each do |entry|
          period_list_array << entry.to_a
        end

        return [] << server_id << act_time.to_a << registration_period << parameter_treepath.to_a << header_list_array << period_list_array << raw_data << profile_signature
      end

    end
    
  end
end
