require 'pp'

require 'smlstream'

@inputFile = "test-data/request.sml"

def handle_escape(bytes)
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

def to_signed(int, bits)  
  mask = (1 << (bits - 1))
  return (int & ~mask) - (int & mask)
end

input = File.open(@inputFile, "rb")
stream = SMLStream.new(input)

list_length = []
list_depth = 0

sml_file = []
parent = []
current_list = sml_file
loop do
  # first, peek for escape sequence
  escape = stream.peek(4).unpack('N')[0]
  if escape == 0x1b1b1b1b
    stream.read(4) # consume peeked bytes
    
    bytes = []
    4.times do
      bytes.push(stream.read(1).unpack('C')[0])
    end
    if handle_escape(bytes) == 1
      4.times do
        stream.pushbyte(0x1b)
      end
    end
  else
    type = nil
    value = nil
    header_length = 0
    length = 0
    # no escape, read tl field
    tl_byte = stream.read(1).unpack('C')[0]
    break if tl_byte.nil?
    
    # check for special cases
    if tl_byte == 0x00
      puts "end of message"
      puts "--------------"
      list_length = []
      list_depth = 0

      current_list << :end_of_message

      current_list = sml_file
      parent = []

      next
    end
    if tl_byte == 0x01
      list_depth.times do print "\t" end
      puts "?"

      current_list << nil

      if not list_length.empty?
        l = list_length.pop
        l -= 1
        list_length.push(l)
      end
      while list_length.last == 0
        list_length.pop
        list_depth -= 1
        current_list = parent.pop
      end

      next
    end

    # parse tl field   
    type_bits = (tl_byte & 0b01110000) >> 4
    case type_bits
    when 0b000
      type = :string
    when 0b100
      type = :bool
    when 0b101
      type = :signed
    when 0b110
      type = :unsigned
    when 0b111
      type = :list
    else
      type = nil
      puts "type: unknown (0b#{type_bits.to_s(2)})"
      exit
    end

    list_depth.times do
      print "\t"
    end

    if not list_length.empty?
      l = list_length.pop
      l -= 1
      list_length.push(l)
    end
    
    length = tl_byte & 0b00001111
    header_length += 1
    while (tl_byte & 0b10000000) != 0
      length << 4
      tl_byte = stream.read(1).unpack('C')[0]
      length |= (tl_byte & 0b00001111)
      header_length += 1
    end

    length -= header_length unless type == :list

    # we know what to expect, lets get it
    case type
    when :string
      value = stream.read(length)
      puts "string: #{value}"
      current_list << value
    when :bool
      value = stream.read(1).unpack('C')[0]
      if value == 0
        value = false
      else
        value = true
      end
      puts "bool: #{value}"
      current_list << value
    when :signed
      value = 0
      bytes_left = length
      while bytes_left > 0
        byte = stream.read(1).unpack('C')[0]
        value = value << 8
        value |= byte
        bytes_left -= 1
      end
      value = to_signed(value, length*8)
      puts "int#{length*8}: #{value}"
      current_list << value
    when :unsigned
      value = 0
      bytes_left = length
      while bytes_left > 0
        byte = stream.read(1).unpack('C')[0]
        value = value << 8
        value |= byte
        bytes_left -= 1
      end
      puts "uint#{length*8}: #{value}"
      current_list << value
    when :list
      puts "list: #{length} elements"
      list_depth += 1
      list_length.push(length)
      new_list = []
      current_list << new_list
      parent.push(current_list)
      current_list = new_list
    end

    while list_length.last == 0
      list_length.pop
      list_depth -= 1
      current_list = parent.pop
    end
  end
end

input.close

pp sml_file
