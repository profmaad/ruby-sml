require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-time'
require 'ruby-sml/sml-treepath'
require 'ruby-sml/sml-periodentry'

module SML
  module GetProfileList

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
        array_rep.shift unless with_raw_data.nil?
        begin_time = SML::Time.construct(array_rep.shift)
        end_time = SML::Time.construct(array_rep.shift)
        parameter_treepath = SML::Treepath.construct(array_rep.shift)
        object_list = array_rep.shift
        das_details = SML::Tree.construct(array_rep.shift)

        return nil if parameter_treepath.nil?
        return SML::GetProfileList::Request.new(server_id, username, password, with_raw_data, begin_time, end_time, parameter_treepath, object_list, das_details)
      end
      def to_a
        result = [] << server_id << username << password << with_raw_data
        result << :bool unless with_raw_data.nil?
        
        return result << begin_time.to_a << end_time.to_a << parameter_treepath.to_a << object_list << das_details.to_a
      end

    end

    class Response
      attr_accessor :server_id, :act_time, :registration_period, :parameter_treepath, :val_time, :status, :period_list, :raw_data, :period_signature

      def initialize(server_id, act_time, registration_period, parameter_treepath, val_time, status, period_list, raw_data, period_signature)
        @server_id = server_id
        @act_time = act_time
        @registration_period = registration_period
        @parameter_treepath = parameter_treepath
        @val_time = val_time
        @status = status
        @period_list = period_list
        @raw_data = raw_data
        @period_signature = period_signature
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        server_id = array_rep.shift
        act_time = SML::Time.construct(array_rep.shift)
        registration_period = array_rep.shift
        array_rep.shift unless registration_period.nil?
        parameter_treepath = SML::Treepath.construct(array_rep.shift)
        val_time = SML::Time.construct(array_rep.shift)
        status = array_rep.shift
        array_rep.shift unless status.nil?
        period_list = []
        array_rep.shift.each do |entry_array_rep|
          entry = SML::PeriodEntry.construct(entry_array_rep)
          return nil if entry.nil?
          period_list << entry
        end
        raw_data = array_rep.shift
        period_signature = array_rep.shift

        return nil if (act_time.nil? or parameter_treepath.nil? or val_time.nil?)
        return SML::GetProfileList::Response.new(server_id, act_time, registration_period, parameter_treepath, val_time, status, period_list, raw_data, period_signature)
      end
      def to_a
        period_list_array = []
        period_list.each do |entry|
          period_list_array << entry.to_a
        end

        result = [] << server_id << act_time.to_a << registration_period
        result << :uint32 unless registration_period.nil?
        result << parameter_treepath.to_a << val_time.to_a << status
        result << :uint64 unless status.nil?

        return result << period_list_array << raw_data << period_signature
      end
      
    end

  end
end
