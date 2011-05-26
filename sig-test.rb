require 'pp'

$: << "./lib"

require 'sml-listentry'

entry = SML::ListEntry.construct([("" << 0x01 << 0x00 << 0x01 << 0x08 << 0x00 << 0xff), 0x08, :uint8, [0x02, :uint8, 1306427347, :uint32], 0x00, 0x01, 0x2342, :uint32, ""])

pp entry

key = File.read("key.pem")
entry.sign("hithere", key)

pp entry

pp entry.verify("hithere", key)
