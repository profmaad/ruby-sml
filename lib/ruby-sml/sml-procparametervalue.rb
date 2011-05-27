require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-periodentry'
require 'ruby-sml/sml-tupelentry'
require 'ruby-sml/sml-time'

module SML

  class ProcParameterValue

    def self.construct(array_rep)
      return nil if array_rep.nil?
      choice = array_rep.shift
      array_rep.shift unless choice.nil?
      body_rep = array_rep.shift

      return case choice
             when 0x01
               body_rep
             when 0x02
               SML::PeriodEntry.construct(body_rep)
             when 0x03
               SML::TupelEntry.construct(body_rep)
             when 0x04
               SML::Time.construct(body_rep)
             end
    end
    def self.to_a(object)
      choice = case object
               when SML::PeriodEntry
                 0x02
               when SML::TupelEntry
                 0x03
               when SML::Time
                 0x04
               else
                 0x01
               end

      result = [] << choice
      result << :uint8 unless choice.nil?
      return result << object
    end

  end

end
