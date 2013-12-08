$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "griffith_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "griffith_common"
  s.version     = GriffithCommon::VERSION
  s.authors     = ["Andrew Griffith"]
  s.email       = ["griffithac@gmail.com"]
  s.homepage    = ""
  s.summary     = "Griffith Common Code"
  s.description = "Common Code for All Griffith Apps."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"

end
