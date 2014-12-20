# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ground_user/version'

Gem::Specification.new do |spec|
  spec.name          = 'ground_user'
  spec.version       = GroundUser::VERSION
  spec.authors       = ['Romain Champourlier']
  spec.email         = ['romain@softr.li']
  spec.summary       = %q{A micro library to isolate user management}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'dotenv', '~> 1.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'guard', '~> 2.10.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.4.1'
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'faker', '~> 1.4'

  spec.add_dependency 'mongoid', '~> 4.0.0'
end
