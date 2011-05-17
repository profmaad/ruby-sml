require 'nilclass-mixin'
require 'sml-treepath'
require 'sml-tree'

module SML
  module SetProcParameter
    
    class Request
      attr_accessor :server_id, :username, :password, :parameter_treepath, :parameter_tree
      
      def initialize(server_id, username, password, parameter_treepath, parameter_tree)
        @server_id = server_id
        @username = username
        @password = password
        @parameter_treepath = parameter_treepath
        @parameter_tree = parameter_tree
      end

      def self.construct(array_rep)
        return nil if array_rep.nil?
        server_id = array_rep.shift
        username = array_rep.shift
        password = array_rep.shift
        parameter_treepath = SML::Treepath.construct(array_rep.shift)
        parameter_tree = SML::Tree.construct(array_rep.shift)

        return nil if (parameter_treepath.nil? or parameter_tree.nil?)
        return SML::SetProcParameter::Request.new(server_id, username, password, parameter_treepath, parameter_tree)
      end
      def to_a
        return [] << server_id << username << password << parameter_treepath.to_a << parameter_tree.to_a
      end

    end
    
  end
end
