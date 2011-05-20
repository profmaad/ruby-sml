require 'crc16'

module SML

  class BinaryTransport

    def self.readfile(io)
      file = String.new
      
      while not io.eof?
        bytes = io.read(4).unpack('N')[0]
        if bytes == 0x1b1b1b1b
          escape = []
          4.times do
            escape.push(io.read(1).unpack('C')[0])
          end
          if handle_escape(escape) == 1
            4.times do
              file << [0x1b].pack('C')
            end
          end
        else
          file << [bytes].pack('N')
        end
      end

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
      result << [(checksum & 0x00ff), ((checksum >> 8) & 0x00ff)].pack('CC')

      io << result
    end

    def self.handle_escape(bytes)
      print "escape sequence: "
      if bytes[0] == 0x01 and bytes[1] == 0x01 and bytes[2] == 0x01 and bytes[3] == 0x01
        puts "data transmission v1"
      elsif bytes[0] == 0x1a
        puts "end of data transmission (padding: #{bytes[1]}, checksum: 0x#{bytes[2].to_s(16)}#{bytes[3].to_s(16)})"
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
