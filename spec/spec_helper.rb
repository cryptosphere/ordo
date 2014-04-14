# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ordo'

def test_vector(name)
  test_vectors_dir = File.expand_path('../test_vectors', __FILE__)
  File.read File.join(test_vectors_dir, name)
end
