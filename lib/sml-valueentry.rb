require 'nilclass-mixin'

module SML
  
  class ValueEntry
    attr_accessor :value, :signature
    
    def initialize(value, signature)
      @value = value
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      value = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::ValueEntry.new(value, signature)
    end
    def to_a
      return [] << value << signature
    end

  end

end
