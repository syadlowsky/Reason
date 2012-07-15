# -*- encoding: utf-8 -*-
require File.expand_path('../lib/reason/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steve Yadlowsky"]
  gem.email         = ["steve.yadlowsky@mylookout.com"]
  gem.description   = %q{Give meaning to your specifications}
  gem.summary       = %q{RSpec unit tests are about enforcing a contract between interacting objects. Manage these contracts when writing your specs}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "reason"
  gem.require_paths = ["lib"]
  gem.version       = Reason.version

  gem.add_runtime_dependency "rspec"
end
