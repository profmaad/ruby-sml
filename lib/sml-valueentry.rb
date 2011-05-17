require 'nilclass-mixin'

module SML
  
  class ValueEntry
    attr_accessor :value, :value_type, :signature
    
    def initialize(value, value_type, signature)
      @value = value
      @value_type = value_type
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      value = array_rep.shift
      value_type = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::ValueEntry.new(value, value_type, signature)
    end
    def to_a
      return [] << value << value_type << signature
    end

  end

end
