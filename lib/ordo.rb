# encoding: binary

require 'ordo/version'
require 'ordo/message'

# Ordered Representation of Distinguished Objects
module ORDO
  # Couldn't parse the given message
  ParseError = Class.new(StandardError)
end
