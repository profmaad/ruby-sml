require 'nilclass-mixin'
require 'sml-time'
require 'sml-valueentry'

module SML
  
  class ProfileObjectPeriodEntry
    attr_accessor :val_time, :status, :value_list, :period_signature

    def initialize(val_time, status, value_list, period_signature)
      @val_time = val_time
      @status = status
      @value_list = value_list
      @period_signature = period_signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      val_time = SML::Time.construct(array_rep.shift)
      status = array_rep.shift
      value_list = []
      array_rep.shift.each do |entry_array_rep|
        entry = SML::ValueEntry.construct(entry_array_rep)
        return nil if entry.nil?
        value_list << entry
      end
      period_signature = array_rep.shift

      return nil if val_time.nil?
      return SML::ProfileObjectPeriodEntry.new(val_time, status, value_list, period_signature)
    end
    def to_a
      value_list_array = []
      value_list.each do |entry|
        value_list_array << entry.to_a
      end
      
      return [] << val_time.to_a << status << value_list_array << period_signature
    end

  end

end
