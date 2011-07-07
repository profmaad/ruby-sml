require 'ruby-sml/sml-listentry'
require 'ruby-sml/sml-periodentry'
require 'ruby-sml/sml-tree'

require 'ruby-sml/obis.rb'

module SML

  module Helpers

    def self.hex_to_s(hex)
      result = ""
      hex.each_byte do |byte|
        result << byte.to_s(16) << ":"
      end
      result.slice!(-1)

      return result
    end

    def self.print_entry(entry)
      return unless (entry.class == SML::ListEntry or entry.class == SML::PeriodEntry)

      name = entry.name
      value = entry.value
      scaler = entry.scaler
      unit = entry.unit

      name = SML::OBIS::resolve(name)
      value = value * (10**entry.scaler) if ((value.class == Fixnum) and not (scaler.nil?))
      value = value.to_f if (value.class == Fixnum)
      unit = SML::Units[unit]["unit"] unless (unit.nil? or SML::Units[unit].nil?)

      puts "#{name}: #{value} #{unit}"
    end

    def self.print_tree(tree)
      return unless tree.class == SML::Tree
      print_tree_internal(tree, 0)
    end
    def self.print_tree_internal(tree, level)
      name = tree.parameter_name
      name = SML::OBIS::resolve(name)

      if level > 0
        (level*4).times do print " " end
        print "|-> " unless level == 0
      end
      puts "#{name} : #{tree.parameter_value}"

      tree.child_list.each do |child|
        print_tree_internal(child, level+1)
      end
    end
    
  end

end
