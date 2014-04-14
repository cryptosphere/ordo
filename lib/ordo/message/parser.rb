# encoding: utf-8

require 'strscan'

module ORDO
  class Message
    # Parses valid ORDO messages
    class Parser
      attr_reader :version, :fields, :body

      def initialize
        @scanner = nil
        @line    = nil
        @version = nil
        @fields  = nil
        @body    = nil
      end

      def parse(message_bytes)
        @line = 1
        @scanner = StringScanner.new(message_bytes)
        parse_prefix

        @fields = {}
        parse_field until body

        self
      end

      def to_ordo_message
        Message.new(body, fields)
      end

      private

      def parse_prefix
        header = @scanner.scan(/---ORDO MSG v/)
        parse_error!('no ORDO MSG header') unless header

        version = @scanner.scan(/[0-9]/)
        parse_error!('invalid version number') unless version
        @version = Integer(version, 10)

        header_rest = @scanner.scan(/---\r\n/)
        parse_error!('invalid ORDO MSG header') unless header_rest

        @line += 1
      end

      # From RFC 3986
      RESERVED_CHARACTERS   = /[!*'();:@&=+$,\/?#\[\]]/
      UNRESERVED_CHARACTERS = /[A-Za-z0-9\-_.~]/

      HEADER_VALUE = /(#{RESERVED_CHARACTERS}|#{UNRESERVED_CHARACTERS})*\r\n/

      def parse_field
        return parse_body if @scanner.scan(/\r\n/)

        name = @scanner.scan(/([A-Z][a-z]*)(-[A-Z][a-z]*)*/)
        parse_error!('invalid header field name') unless name

        colon = @scanner.scan(/: /)
        parse_error!('expecting ": " but none found') unless colon

        value = @scanner.scan(HEADER_VALUE)
        parse_error!('invalid characters in header value') unless value

        @fields[name] = value.chomp
        @line += 1
      end

      def parse_body
        @body = @scanner.rest
      end

      def parse_error(message)
        buffer = @scanner.rest.split(/\r|\n/).first
        buffer = "#{buffer[0, 20]}..." if buffer.length > 20

        ParseError.new("#{message} (line: #{@line}): #{buffer}")
      end

      def parse_error!(message)
        fail parse_error(message)
      end
    end
  end
end
