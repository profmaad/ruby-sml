module SML

  class ProfileObjectHeaderEntry
    attr_accessor :name, :unit, :scaler
    
    def initialize(name, unit, scaler)
      @name = name
      @unit = unit
      @scaler = scaler
    end

    def self.construct(array_rep)
      name = array_rep.shift.to_s
      unit = array_rep.shift.to_i
      scaler = array_rep.shift.to_i

      return SML::ProfileObjectHeaderEntry.new(name, unit, scaler)
    end

  end

end
