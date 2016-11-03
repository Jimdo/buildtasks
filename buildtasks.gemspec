# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildtasks/version'

Gem::Specification.new do |spec|
  spec.name          = "buildtasks"
  spec.version       = BuildTasks::VERSION.dup
  spec.authors       = ["Mathias Lafeldt"]
  spec.email         = ["mathias.lafeldt@jimdo.com"]
  spec.summary       = %q{Rake tasks to build Debian packages}
  spec.description   = %q{Rake tasks to build Debian packages}
  spec.homepage      = "https://github.com/Jimdo/buildtasks"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop", "~> 0.45.0"
end
