require 'sml-periodentry'
require 'sml-tupelentry'
require 'sml-time'

module SML

  class ProcParameterValue
    def self.construct(array_rep)
      return nil if array_rep.nil?
      choice = array_rep.shift
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
  end

end
