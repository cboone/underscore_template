# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_underscore_templates/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Christopher Boone']
  gem.email         = ['info@hypsometry.com']
  gem.description   = %q{Underscore template support for Rails asset pipeline}
  gem.summary       = %q{Underscore templates for Rails}
  gem.homepage      = 'http://github.com/cboone/rails_underscore_templates'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'rails_underscore_templates'
  gem.require_paths = ['lib']
  gem.version       = RailsUnderscoreTemplates::VERSION

  gem.add_dependency 'actionpack', '>= 3.1'
end
