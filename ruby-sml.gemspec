require 'rake'

Gem::Specification.new do |s|
  s.name = 'ruby-sml'
  s.version = '0.1'
  s.summary = 'Pure ruby implementation of the Smart Messaging Language protocol'
  s.description = <<-EOF
  ruby-sml implements the Smart Messaging Language specification 1.3 (http://www.vde.de/de/fnn/arbeitsgebiete/messwesen/documents/Spezifikation_SML_1-03.pdf) in pure ruby. So far, only transport protocol v1 is supported.
  EOF
  s.email = 'himself@prof-maad.org'
  s.homepage = 'https://prof-maad.org'
  s.author = 'Prof. MAAD'
  s.license = 'BSD'
  s.date = '2010-05-27'

  s.files = FileList['lib/**/*.rb', 'lib/ruby-sml.rb', 'sample.rb', 'README.md', 'LICENSE']
#  s.require_paths = ['lib']
end
