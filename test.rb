require 'pp'

$: << "./lib"

require 'lib/transport-binary'
require 'lib/encoding-binary'
require 'lib/sml-file'

@inputFile = "test-data/request.sml"
#@inputFile = "test-data/response.sml"

io = File.open(@inputFile, 'rb')

encodedFile = SML::BinaryTransport.readfile(io)
puts "Encoded File:"
count = 0
encodedFile.each_byte do |byte|
  print "0x%02x " % byte
  count += 1
  if count > 8
    count = 0
    puts
  end
end
puts
puts "-------------"

decodedFile = SML::BinaryEncoding.decode_file(encodedFile)
puts "Decoded FIle:"
pp decodedFile
puts "-------------"

sml_file = SML::File.construct(decodedFile)
pp sml_file

io.close
