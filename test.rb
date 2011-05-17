require 'pp'

$: << "./lib"

require 'lib/transport-binary'
require 'lib/encoding-binary'
require 'lib/sml-file'

@inputFile = "test-data/request.sml"
@outputFile = "test-data/request_processed.sml"

io = File.open(@inputFile, 'rb')

encodedFile = SML::BinaryTransport.readfile(io)
puts "Encoded File:"
count = 0
encodedFile.each_byte do |byte|
  print "0x%02x " % byte
  count += 1
  if count > 7
    count = 0
    puts
  end
end
puts
puts "-------------"

io.close

decodedFile = SML::BinaryEncoding.decode_file(encodedFile)
puts "Decoded File:"
pp decodedFile
puts "-------------"

sml_file = SML::File.construct(decodedFile)
puts "Parsed File:"
pp sml_file
puts "-------------"

sml_file_array_rep = sml_file.to_a
puts "Unparsed File:"
pp sml_file_array_rep
puts "-------------"

reencodedFile = SML::BinaryEncoding.encode_file(sml_file_array_rep)
puts "Reencoded File:"
count = 0
reencodedFile.each_byte do |byte|
  print "0x%02x " % byte
  count += 1
  if count > 7
    count = 0
    puts
  end
end
puts
puts "-------------"

io_out = File.open(@outputFile, 'wb')
SML::BinaryTransport.writefile(io_out, reencodedFile)
io_out.close
