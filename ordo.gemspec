# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ordo/version'

Gem::Specification.new do |spec|
  spec.name          = 'ordo'
  spec.version       = ORDO::VERSION
  spec.authors       = ['Tony Arcieri']
  spec.email         = ['bascule@gmail.com']
  spec.description   = 'Tools for working with the Ordo certificate format'
  spec.summary       = 'Interchange format for cryptographic identities, keys, and signatures'
  spec.homepage      = 'https://github.com/cryptosphere/ordo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rubocop'
end
