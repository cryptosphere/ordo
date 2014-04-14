# encoding: binary

require 'forwardable'
require 'ordo/message/parser'

module ORDO
  # Parse and generate valid ORDO messages
  class Message
    # Current version number of the message format
    MESSAGE_VERSION = 0

    extend Forwardable

    attr_reader :fields, :body
    def_delegator :@fields, :[]

    def self.parse(message_bytes)
      Parser.new.parse(message_bytes).to_ordo_message
    end

    def initialize(body, fields = {})
      @body   = body

      # TODO: validate fields
      @fields = fields
    end

    def to_string
      result = "---ORDO MSG v#{MESSAGE_VERSION}---\r\n"
      fields.each do |key, value|
        result << "#{key}: #{value}\r\n"
      end
      result << "\r\n"
      result << body
    end
  end
end
