require 'nilclass-mixin'
require 'sml-procparametervalue'

module SML

  class Tree
    attr_accessor :parameter_name, :parameter_value, :child_list

    def initialize(parameter_name, parameter_value, child_list)
      @parameter_name = parameter_name
      @parameter_value = parameter_value
      @child_list = child_list
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      parameter_name = array_rep.shift
      parameter_value = SML::ProcParameterValue.construct(array_rep.shift)
      child_list = []
      array_rep.shift.each do |entry_array_rep|
        entry = SML::Tree.construct(entry_array_rep)
        return nil if entry.nil?
        child_list << entry
      end

      return SML::Tree.new(parameter_name, parameter_value, child_list)
    end
    def to_a
      child_list_array = []
      child_list.each do |entry|
        child_list_array << entry.to_a
      end

      return [] << parameter_name << SML::ProcParameterValue.to_a(parameter_value) << child_list_array
    end

  end

end
