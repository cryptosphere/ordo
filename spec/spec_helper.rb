# encoding: utf-8

require 'json'
require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'ordo'

def test_vector(name)
  test_vectors_dir = File.expand_path('../test_vectors', __FILE__)
  File.read File.join(test_vectors_dir, name)
end
