require 'nilclass-mixin'
require 'sml-message'

module SML

  class File
    attr_accessor :messages

    def initialize(messages)
      @messages = messages
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      messages = []
      array_rep.each do |message_array|
        message = SML::Message.construct(message_array)
        return nil if message.nil?
        messages << message
      end

      file = SML::File.new(messages)

      return file
    end
    def to_a
      result = []
      messages.each do |message|
        result << message.to_a
      end

      return result
    end

  end

end
