require 'nilclass-mixin'

module SML

  class ProfileObjectHeaderEntry
    attr_accessor :name, :unit, :scaler
    
    def initialize(name, unit, scaler)
      @name = name
      @unit = unit
      @scaler = scaler
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      unit = array_rep.shift
      scaler = array_rep.shift

      return SML::ProfileObjectHeaderEntry.new(name, unit, scaler)
    end
    def to_a
      return [] << name << unit << scaler
    end

  end

end
