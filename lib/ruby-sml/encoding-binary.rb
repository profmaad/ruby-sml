module SML

  class BinaryEncoding

    def self.decode_file(file)
      source = String.new(file)
      sml_file = []
      position = 0
      
      list_length = []
      list_depth = 0
      parent = []
      current_list = sml_file

      while not source.empty?
        type = nil
        value = nil
        header_length = 0
        length = 0
        tl_byte = source.slice!(0,1).unpack('C')[0]
        break if tl_byte.nil?
        
        # check for special cases
        if tl_byte == 0x00
#           puts "end of message"
#           puts "--------------"
          list_length = []
          list_depth = 0

          current_list << :end_of_message

          current_list = sml_file
          parent = []

          next
        end
        if tl_byte == 0x01
#           list_depth.times do print "\t" end
#           puts "?"

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
#          puts "type: unknown (0b#{type_bits.to_s(2)})"
          exit
        end

        list_depth.times do
#           print "\t"
        end

        if not list_length.empty?
          l = list_length.pop
          l -= 1
          list_length.push(l)
        end
        
        length = tl_byte & 0b00001111
        header_length += 1
        while (tl_byte & 0b10000000) != 0
          length = length << 4
          tl_byte = source.slice!(0,1).unpack('C')[0]
          length |= (tl_byte & 0b00001111)
          header_length += 1
        end
        
        length -= header_length unless type == :list
 
        # we know what to expect, lets get it
        case type
        when :string
          value = source.slice!(0,length)
#           puts "string(#{length}): #{value}"
          current_list << value
        when :bool
          value = source.slice!(0,1).unpack('C')[0]
          if value == 0
            value = false
          else
            value = true
          end
#           puts "bool: #{value}"
          current_list << value << :bool
        when :signed
          value = 0
          bytes_left = length
          while bytes_left > 0
            byte = source.slice!(0,1).unpack('C')[0]
            value = value << 8
            value |= byte
            bytes_left -= 1
          end
          value = to_signed(value, length*8)
#           puts "int#{length*8}: #{value}"
          current_list << value << "int#{length*8}".to_sym
        when :unsigned
          value = 0
          bytes_left = length
          while bytes_left > 0
            byte = source.slice!(0,1).unpack('C')[0]
            value = value << 8
            value |= byte
            bytes_left -= 1
          end
#           puts "uint#{length*8}: #{value}"
          current_list << value << "uint#{length*8}".to_sym
        when :list
#           puts "list: #{length} elements"
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

      return sml_file
    end

    def self.encode_file(file)
      result = String.new

      array_rep = Array.new(file)
      array_rep.each do |message|
        result << encode_value(message, :array) << 0x00
      end

      return result
    end

    def self.encode_value(value, type)
      result = String.new

      case type
      when :array
        entries_with_type = []
        while not value.empty?
          entry = value.shift
          type = case entry
                 when Array
                   :array
                 when String
                   :string
                 when NilClass
                   :nil
                 when Fixnum
                   value.shift
                 end

          entries_with_type << [entry, type]
        end
        
        tl_bytes = encode_length(entries_with_type.length, false)
        tl_bytes[0] = 0b01110000 + tl_bytes[0]
        tl_bytes.each do |byte|
          result << byte
        end
        entries_with_type.each do |entry, type|
          result << encode_value(entry,type)
        end
      when :string
        tl_bytes = encode_length(value.length, true)
        tl_bytes[0] = 0b00000000 + tl_bytes[0]
        tl_bytes.each do |byte|
          result << byte
        end
        result << value
      when :int8
        result << 0x52 << [value].pack('c')
      when :int16
        result << 0x53
        result << [value].pack('s').reverse
      when :int32
        result << 0x55
        result << [value].pack('l').reverse
      when :int64
        result << 0x59
        result << [value].pack('q').reverse
      when :uint8
        result << 0x62 << [value].pack('C')
      when :uint16
        result << 0x63 << [value].pack('n')
      when :uint32
        result << 0x65 << [value].pack('N')
      when :uint64
        result << 0x69 << [value].pack('Q').reverse
      when :bool
        if value == 0
          result << 0x42 << 0x00
        else          
          result << 0x42 << 0x01
        end
      when :nil
        result << 0x01
      end
      
      return result
    end
    def self.encode_length(length, include_header)
      result = []

      header_length = 1
      while (length+(include_header ? header_length : 0)) >= 2**(4*header_length)
        header_length += 1        
      end
      total_length = length + (include_header ? header_length : 0)

      while header_length > 0
        mask = 0xf << (header_length-1)*4
        result << ((total_length & mask) >> (header_length-1)*4)
        header_length -= 1
      end

      return result
    end

    def self.to_signed(int, bits)  
      mask = (1 << (bits - 1))
      return (int & ~mask) - (int & mask)
    end
   
  end
end
