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

    Lookup["\x81\x81\xc7\x89\xe1\xff"] = "Event Log"
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
    Lookup["\x00\x00\x60\x08\x00\xff"] = "Seconds counter"
    Lookup["\x81\x00\x00\x09\x0b\x01"] = "Timezone Offset"

    Lookup["\x00\x00\x60\x0e\x00\xff"] = "Selected Tariff"

    Lookup["\x81\x81\x27\x32\x07\x01"] = "Log Entry Period"
    
    Lookup["\x81\x00\x60\x05\x00\x00"] = "Status word"

    Lookup["\x81\x01\x00\x00\x01\x00"] = "Interface name"
    Lookup["\x81\x03\x00\x00\x01\x00"] = "Interface name"

    Lookup["\x81\x81\x81\x60\xff\xff"] = "Rights and Roles Root"
    Lookup["\x81\x81\x81\x60\x01\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x02\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x03\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x04\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x05\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x06\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x07\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x08\xff"] = "Role"
    Lookup["\x81\x81\x81\x60\x01\x01"] = "Access Right" # actualle all of \x81\x81\x81\x60\x0[1-8]\x[01-fe]
    Lookup["\x81\x81\x81\x61\xff\xff"] = "Username"
    Lookup["\x81\x81\x81\x62\xff\xff"] = "Password"
    Lookup["\x81\x81\x81\x63\xff\xff"] = "Public Key for User Access"
    Lookup["\x81\x81\x81\x64\x01\x01"] = "ACL for Server ID" # actually all ending with \x01 to \xfe

    Lookup["\x81\x02\x00\x07\x00\xff"] = "Enduser Interface Root"
    Lookup["\x81\x02\x00\x07\x01\xff"] = "Enduser IP Acquisition Method"
    Lookup["\x81\x02\x17\x07\x00\x01"] = "Enduser manually assigned IP Address"
    Lookup["\x81\x02\x17\x07\x01\x01"] = "Enduser manually assigned Network Mask"
    Lookup["\x81\x02\x00\x07\x02\xff"] = "Enduser DHCP Server active"
    Lookup["\x81\x02\x00\x07\x02\x01"] = "Enduser DHCP Local Netmask"
    Lookup["\x81\x02\x00\x07\x02\x02"] = "Enduser DHCP Default Gateway"
    Lookup["\x81\x02\x00\x07\x02\x03"] = "Enduser DHCP DNS Server"
    Lookup["\x81\x02\x00\x07\x02\x04"] = "Enduser DHCP IP Pool Start"
    Lookup["\x81\x02\x00\x07\x02\x05"] = "Enduser DHCP IP Pool End"
    Lookup["\x81\x02\x00\x07\x10\xff"] = "Enduser Interface Status Root"
    Lookup["\x81\x02\x17\x07\x00\x00"] = "Enduser Current IP Address"

    Lookup["\x81\x04\x00\x06\x00\xff"] = "WAN Interface Status Root"
    Lookup["\x81\x04\x00\x00\x01\x00"] = "WAN Interface Name"
    Lookup["\x81\x04\x00\x02\x00\x00"] = "WAN Interface Firmware Version"
    Lookup["\x81\x04\x00\x07\x00\xff"] = "WAN Interface Parameter Root"
    Lookup["\x81\x04\x27\x32\x03\x01"] = "WAN Interface automatic Reboot"
    Lookup["\x81\x42\x64\x3c\x01\x01"] = "WAN Interface Max. Inter Message Timeout"
    Lookup["\x81\x42\x64\x3c\x01\x02"] = "WAN Interface Max. Timeout from Close-Request to Open-Response"

    Lookup["\x81\x04\x02\x07\x00\xff"] = "GSM Parameter Root"
    Lookup["\x81\x04\x00\x32\x01\x01"] = "GSM SIM PIN"
    Lookup["\x81\x04\x00\x32\x04\x01"] = "GSM Provider Selection Method"
    Lookup["\x81\x04\x00\x32\x08\x01"] = "GSM Bearer Service Type"
    Lookup["\x81\x04\x00\x32\x09\x01"] = "GSM Quality of Service"
    Lookup["\x81\x04\x27\x32\x01\x01"] = "GSM Max. Connection Length"
    Lookup["\x81\x04\x27\x32\x02\x01"] = "GSM Connection Idle Time"
    Lookup["\x81\x04\x31\x32\x01\x01"] = "GSM Number of Rings until Call pickup"

    Lookup["\x81\x49\x0d\x06\x00\xff"] = "IPT Status Root"
    Lookup["\x81\x49\x17\x07\x00\x00"] = "IPT Current Master Target IP Address"
    Lookup["\x81\x49\x1a\x07\x00\x00"] = "IPT Current Master Target Port"
    Lookup["\x81\x49\x19\x07\x00\x00"] = "IPT Current Master Source Port"
    Lookup["\x81\x49\x0d\x07\x00\xff"] = "IPT Parameter Root"
    Lookup["\x81\x49\x0d\x07\x00\x01"] = "IPT Primary Master Root"
    Lookup["\x81\x49\x17\x07\x00\x01"] = "IPT Primary Master Target IP Address"
    Lookup["\x81\x49\x1a\x07\x00\x01"] = "IPT Primary Master Target Port"
    Lookup["\x81\x49\x19\x07\x00\x01"] = "IPT Primary Master Source Port"
    Lookup["\x81\x49\x63\x3c\x01\x01"] = "IPT Primary Master Username"
    Lookup["\x81\x49\x63\x3c\x02\x01"] = "IPT Primary Master Password"
    Lookup["\x81\x49\x0d\x07\x00\x02"] = "IPT Secondary Master Root"
    Lookup["\x81\x49\x17\x07\x00\x02"] = "IPT Secondary Master Target IP Address"
    Lookup["\x81\x49\x1a\x07\x00\x02"] = "IPT Secondary Master Target Port"
    Lookup["\x81\x49\x19\x07\x00\x02"] = "IPT Secondary Master Source Port"
    Lookup["\x81\x49\x63\x3c\x01\x02"] = "IPT Secondary Master Username"
    Lookup["\x81\x49\x63\x3c\x02\x02"] = "IPT Secondary Master Password"
    Lookup["\x81\x48\x27\x32\x06\x01"] = "IPT Connection Retry Timeout"
    Lookup["\x81\x48\x31\x32\x02\x01"] = "IPT Max. Connection Retries"

    Lookup["\x81\x04\x00\x33\x01\xff"] = "AT-Hayes-Strings Root"
    Lookup["\x81\x04\x00\x33\x01\x01"] = "AT-Hayes-String after Modem Power-On, before PIN-Entry"
    Lookup["\x81\x04\x00\x33\x02\x01"] = "AT-Hayes-String after PIN-Entry"
    Lookup["\x81\x04\x00\x33\x03\x01"] = "AT-Hayes-String GPRS Initialization"

  end

end
