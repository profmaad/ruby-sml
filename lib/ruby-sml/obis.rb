require 'ruby-sml/helpers'

module SML

  module OBIS

    def resolve(obis)
      if SML::OBIS::Lookup[obis].nil?
        return SML::Helpers::hex_to_s(obis)
      else
        return SML::OBIS::Lookup[obis]
      end
    end

    Lookup = {}

    

  end

end
