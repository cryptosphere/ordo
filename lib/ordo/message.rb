# encoding: utf-8

require 'forwardable'
require 'ordo/message/parser'

module ORDO
  # Parse and generate valid ORDO messages
  class Message
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
  end
end
