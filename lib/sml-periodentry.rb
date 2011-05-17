require 'nilclass-mixin'

module SML

  class PeriodEntry
    attr_accessor :name, :unit, :scaler, :value, :signature

    def initialize(name, unit, scaler, value, signature)
      @name = name
      @unit = unit
      @scaler = scaler
      @value = value
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      unit = array_rep.shift
      scaler = array_rep.shift
      value = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::PeriodEntry.new(name, unit, scaler, value, signature)
    end
    def to_a
      return [] << name << unit << scaler << value << signature
    end

  end

end
