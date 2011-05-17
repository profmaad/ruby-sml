require 'nilclass-mixin'

module SML

  class Time
    attr_accessor :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      choice = array_rep.shift
      type = case choice
             when 0x01
               :seconds_index
             when 0x02
               :timestamp
             end
      value = array_rep.shift

      return SML::Time.new(type, value)
    end
    def to_a
      choice = case type
               when :seconds_index
                 0x01
               when :timestamp
                 0x02
               end

      return [] << choice << value
    end

  end

end
