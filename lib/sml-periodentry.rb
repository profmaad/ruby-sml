require 'nilclass-mixin'

module SML

  class PeriodEntry
    attr_accessor :name, :unit, :scaler, :value, :value_type, :signature

    def initialize(name, unit, scaler, value, value_type, signature)
      @name = name
      @unit = unit
      @scaler = scaler
      @value = value
      @value_type = value_type
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      unit = array_rep.shift
      scaler = array_rep.shift
      array_rep.shift unless scaler.nil?
      value = array_rep.shift
      value_type = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::PeriodEntry.new(name, unit, scaler, value, value_type, signature)
    end
    def to_a
      result = [] << name << unit << scaler
      result << :int8 unless scaler.nil?
      return result << value << value_type << signature
    end

  end

end
