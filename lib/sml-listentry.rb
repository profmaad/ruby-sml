require 'nilclass-mixin'
require 'sml-time'

module SML

  class ListEntry
    attr_accessor :name, :status, :value_time, :unit, :scaler, :value, :signature

    def initialize(name, status, value_time, unit, scaler, value, signature)
      @name = name
      @status = status
      @value_time = value_time
      @unit = unit
      @scaler = scaler
      @value = value
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      status = array_rep.shift
      value_time = SML::Time.construct(array_rep.shift)
      unit = array_rep.shift
      scaler = array_rep.shift
      value = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::ListEntry.new(name, status, value_time, unit, scaler, value, signature)
    end
    def to_a
      return [] << name << status << value_time.to_a << unit << scaler << value << signature
    end

  end

end
