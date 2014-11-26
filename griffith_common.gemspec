require './lib/griffith_common/version'

Gem::Specification.new do |s|
  s.name                      = "griffith_common"
  s.version                   = GriffithCommon::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = ["Andrew Griffith"]
  s.date                      = "2014-01-25"
  s.description               = "Common code used by Griffith Industries, Inc."
  s.email                     = ["griffithac@gmail.com"]
  s.files                     = `git ls-files`.split($/)
  s.executables               = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files                = s.files.grep(%r{^(test|spec|features)/})
 
  s.homepage                  = "http://www.griffithind.com"
  s.require_paths             = ["lib"]
  s.required_ruby_version     = Gem::Requirement.new("~> 2.0")
  s.rubygems_version          = "2.2.2"
  s.summary                   = "This gem contains all the common code use by Griffith Industries, Inc. It is licensed as MIT.  Hopefully it will be useful to others."

  s.add_runtime_dependency('will_paginate', ["~> 3.0.5"])
  s.add_runtime_dependency('bootstrap-sass', [">= 3.1.1.1"])
  s.add_runtime_dependency('autoprefixer-rails')
  s.add_runtime_dependency('font-awesome-rails')
  s.add_runtime_dependency('bootstrap-datepicker-rails')
  s.add_runtime_dependency('simple_form')
  s.add_development_dependency('sqlite3', [">= 0"])
  s.add_development_dependency('pry', [">= 0"])
end

