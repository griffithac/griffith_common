$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "griffith_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "griffith_common"
  s.version     = GriffithCommon::VERSION
  s.authors     = ["Andrew Griffith"]
  s.email       = ["griffithac@gmail.com"]
  s.homepage    = "http://www.griffithind.com"
  s.summary     = "Summary of GriffithCommon."
  s.description = "Description of GriffithCommon."


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]

  s.required_ruby_version = '~> 2.0'
  
  # s.add_dependency "rails", "~> 4.0.2"

  s.add_dependency "will_paginate", '~> 3.0.3'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
