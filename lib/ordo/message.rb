# encoding: utf-8

require 'ordo/message/parser'

module ORDO
  # Parse and generate valid ORDO messages
  class Message
    def self.parse(message_bytes)
      Parser.new(message_bytes).to_ordo_message
    end
  end
end
