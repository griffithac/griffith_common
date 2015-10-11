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
end

