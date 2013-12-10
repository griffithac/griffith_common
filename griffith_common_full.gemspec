$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "griffith_common_full/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "griffith_common_full"
  s.version     = GriffithCommonFull::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GriffithCommonFullFull."
  s.description = "TODO: Description of GriffithCommonFullFull."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.0.2"

  s.add_dependency "will_paginate", '~> 3.0.3'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
