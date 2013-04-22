# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tinysong/version'

Gem::Specification.new do |spec|
  spec.name          = "tinysong"
  spec.version       = Tinysong::VERSION
  spec.authors       = ["Linus Oleander"]
  spec.email         = ["linus@oleander.nu"]
  spec.description   = %q{Unofficial ruby library for tinysong.com}
  spec.summary       = %q{This library scrapes tinysong.com, which means that there aren't any request limitations}
  spec.homepage      = "https://github.com/oleander/tinysong-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency("rest-client")
  spec.add_dependency("nokogiri")

  spec.add_development_dependency("vcr")
  spec.add_development_dependency("rspec")  
  spec.add_development_dependency("webmock", "~> 1.8.0")

  spec.required_ruby_version = ">= 1.9.2"
end