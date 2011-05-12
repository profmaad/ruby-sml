class SMLStream
  def initialize(io)
    @io = io
    @buffer = String.new
    @position = 0
  end

  def read(n)
    @position = 0
    result = String.new
    n.times do
      if not @buffer.empty?
        result << @buffer.slice!(0)
      else
        byte = @io.read(1)        
        result << byte unless byte.nil?
      end
    end

    return result
  end
  def peek(n)
    result = String.new
    temp_buffer = String.new
    n.times do
      if @buffer[@position]
        result << @buffer[@position]
        @position += 1
      else
        @position = 0
        byte = @io.read(1)
        temp_buffer << byte unless byte.nil?
        result << byte unless byte.nil?
      end
    end
    @buffer << temp_buffer

    return result
  end

  def pushbyte(byte)
    @buffer << byte
  end
end
