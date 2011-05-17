require 'nilclass-mixin'
require 'sml-time'

module SML

  class ListEntry
    attr_accessor :name, :status, :status_type, :value_time, :unit, :scaler, :value, :value_type, :signature

    def initialize(name, status, status_type, value_time, unit, scaler, value, value_type, signature)
      @name = name
      @status = status
      @status_type = status_type
      @value_time = value_time
      @unit = unit
      @scaler = scaler
      @value = value
      @value_type = value_type
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      status = array_rep.shift
      status_type = array_rep.shift
      value_time = SML::Time.construct(array_rep.shift)
      unit = array_rep.shift
      scaler = array_rep.shift
      value = array_rep.shift
      value_type = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::ListEntry.new(name, status, status_type, value_time, unit, scaler, value, value_type, signature)
    end
    def to_a
      return [] << name << status << status_type << value_time.to_a << unit << scaler << value << value_type << signature
    end

  end

end
