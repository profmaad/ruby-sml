module SML

  class Treepath
    attr_accessor :path_entry

    def initialize(path_entry)
      @path_entry = path_entry
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      path_entry = array_rep.shift
      
      return SML::Treepath.new(path_entry)
    end

  end

end
