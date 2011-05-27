require 'ruby-sml/crc16'

module SML

  class BinaryTransport

    def self.readfile(io)
      file = String.new
      received_checksum_bytes = String.new
      raw = String.new
      
      while not io.eof?
        bytes_raw = io.read(4)
        raw << bytes_raw
        bytes = bytes_raw.unpack('N')[0]
        if bytes == 0x1b1b1b1b
          escape = []
          4.times do
            byte = io.read(1)
            raw << byte
            escape.push(byte.unpack('C')[0])
          end
          escape_return = handle_escape(escape)
          case escape_return
          when 1
            4.times do
              file << [0x1b].pack('C')
            end
          when String
            received_checksum_bytes = escape_return
          end
        else
          file << [bytes].pack('N')
        end
      end

      # calculate CRC16 over all received bytes (except last 2 - they contain the checksum itself)
      raw.chop!.chop!
      calculated_checksum = CRC16.crc16(raw)
      calculated_checksum = (calculated_checksum ^ 0xffff)
      calculated_checksum = ((calculated_checksum & 0xff00) >> 8) | ((calculated_checksum & 0x00ff) << 8)
      # unpack the checksum we received
      received_checksum = received_checksum_bytes.unpack('n')[0]

      return nil unless calculated_checksum == received_checksum
      return file
    end
    def self.writefile(io, file)
      source = String.new(file)
      result = String.new

      # add transport begin header
      result << [0x1b1b1b1b, 0x01010101].pack('NN')

      while not source.empty?
        value = source.unpack('N')[0]
        if value == 0x1b1b1b1b
          result << [0x1b1b1b1b].pack('N')
          result << source.slice!(0,4)
        else
          result << source.slice!(0,1)
        end
      end

      # calculate padding length
      padding_length = (4-(file.length % 4)) % 4

      # add padding
      padding_length.times do
        result << 0x00
      end
      # add transmission end header
      result << [0x1b1b1b1b, 0x1a, padding_length].pack('NCC')

      # calculate checksum
      checksum = CRC16.crc16(result)
      checksum = (checksum ^ 0xffff)
      result << [(checksum & 0x00ff), ((checksum >> 8) & 0x00ff)].pack('CC')

      io << result
    end

    def self.handle_escape(bytes)
      print "escape sequence: "
      if bytes[0] == 0x01 and bytes[1] == 0x01 and bytes[2] == 0x01 and bytes[3] == 0x01
        puts "data transmission v1"
      elsif bytes[0] == 0x1a
        puts "end of data transmission (padding: #{bytes[1]}, checksum: 0x#{bytes[2].to_s(16)}#{bytes[3].to_s(16)})"
        return "" << bytes[2] << bytes[3]
      elsif bytes[0] == 0x02
        puts "data transmission v2"
      elsif bytes[0] == 0x03
        puts "v2 set timeout"
      elsif bytes[0] == 0x04
        puts "v2 set block size"
      elsif bytes[0] == 0x1b and bytes[1] == 0x1b and bytes[2] == 0x1b and bytes[3] == 0x1b
        puts "literal escape :("
        return 1
      else
        print "unknown ["
        print "0x%08x" % escape
        puts "]"
      end
      return 0
    end
  end

end
