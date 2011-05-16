require 'sml-value'

module SML
  
  class ValueEntry
    attr_accessor :value, :signature
    
    def initialize(value, signature)
      @value = value
      @signature = signature
    end

    def self.construct(array_rep)
      value = array_rep.shift
      signature = array_rep.shift.to_s

      return nil if value.nil?
      return SML::ValueEntry.new(value, signature)
    end

  end

end
