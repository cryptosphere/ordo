# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ordo/version'

Gem::Specification.new do |spec|
  spec.name          = "ordo"
  spec.version       = Ordo::VERSION
  spec.authors       = ["Tony Arcieri"]
  spec.email         = ["tony.arcieri@gmail.com"]
  spec.description   = "Tools for working with the Ordo certificate format"
  spec.summary       = "Ordo is a data interchange format for cryptographic identities, keys, and signatures"
  spec.homepage      = "https://github.com/cryptosphere/ordo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "kpeg"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
