# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "date_supercharger/version"

Gem::Specification.new do |spec|
  spec.name          = "date_supercharger"
  spec.version       = DateSupercharger::VERSION
  spec.authors       = ["Simon Soriano"]
  spec.email         = ["simon0191@gmail.com"]
  spec.summary       = "A nice shortcut for date queries"
  spec.description   = "A nice shortcut for date queries"
  spec.homepage      = "https://github.com/simon0191/date_supercharger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "codeclimate-test-reporter"
end
