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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.0.2"

  s.add_dependency "will_paginate", '~> 3.0.3'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
