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
