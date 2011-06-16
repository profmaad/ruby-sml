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

    Lookup["\x81\x81\xc7\x82\x01\xff"] = "Device Properties Root"
    Lookup["\x81\x81\xc7\x82\x02\xff"] = "Device Class"
    Lookup["\x81\x81\xc7\x82\x03\xff"] = "Manufacturer"
    Lookup["\x81\x81\xc7\x82\x05\xff"] = "Public Key"

    Lookup["\x01\x00\x00\x00\x09\xff"] = "Device ID"
    Lookup["\x01\x00\x00\x02\x00\xff"] = "Firmware Version"
    Lookup["\x01\x00\x00\x02\x02\xff"] = "Control Program Nr"

    Lookup["\x81\x81\xc7\x89\xe1\xff"] = "Event log"
    Lookup["\x81\x81\xc7\x89\xe2\xff"] = "Event ID"

    Lookup["\x81\x81\xc7\x8c\x01\xff"] = "INFO interface active"
    Lookup["\x81\x81\xc7\x8c\x02\xff"] = "EDL40 mode"
    Lookup["\x81\x81\xc7\x8c\x03\xff"] = "Delete old usage values"
    Lookup["\x81\x81\xc7\x8c\x04\xff"] = "Display old usage values"
    Lookup["\x81\x81\xc7\x8c\x06\xff"] = "Display Text on INFO display"
    Lookup["\x81\x81\xc7\x8c\x07\xff"] = "Displayed Tariff Registers Bitmask"
    Lookup["\x81\x81\xc7\x8c\x08\xff"] = "Advanced Manufacturer Dataset on MSB"
    Lookup["\x81\x81\xc7\x8c\x09\xff"] = "History Delete via Blinken- Interface enabled"
    Lookup["\x81\x81\xc7\x8c\x0a\xff"] = "Display PIN Protected enabled"
    Lookup["\x81\x81\xc7\x8c\x0b\xff"] = "Display PIN Code"
    Lookup["\x81\x81\xc7\x8c\x0c\xff"] = "Number of Manipulation Attempts"
    Lookup["\x81\x81\xc7\x8c\x0d\xff"] = "Automatic PIN Protected after Timeout enabled"

    Lookup["\x01\x00\x01\x08\x00\xff"] = "Current Value - Overall Register"
    Lookup["\x01\x00\x01\x08\x01\xff"] = "Current Value - Register Tariff 1"
    Lookup["\x01\x00\x01\x08\x02\xff"] = "Current Value - Register Tariff 2"
    Lookup["\x01\x00\x01\x11\x00\xff"] = "Last signed overall Register Value"
    Lookup["\x01\x00\x0f\x07\x00\xff"] = "Current Meter Reading"

    Lookup["\x01\x00\x01\x08\x00\x60"] = "Usage History - last Day"
    Lookup["\x01\x00\x01\x08\x00\x61"] = "Usage History - last 7 Days"
    Lookup["\x01\x00\x01\x08\x00\x62"] = "Usage History - last 30 Days"
    Lookup["\x01\x00\x01\x08\x00\x63"] = "Usage History - last 365 Days"

    Lookup["\x01\x00\x00\x09\x0b\x00"] = "Current Time"
    Lookup["\x01\x00\x00\x09\x0b\x01"] = "Former Time"

    Lookup["\x00\x00\x60\x0e\x00\xff"] = "Selected Tariff"

  end

end
