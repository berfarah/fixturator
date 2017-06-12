$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fixturator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fixturator"
  s.version     = Fixturator::VERSION
  s.authors     = ["Bernardo Farah"]
  s.email       = ["bernardo@coverhound.com"]

  s.summary     = "Fixturator is a fixture generator for ActiveRecord models"
  s.description = "Fixturator is a fixture generator for ActiveRecord models"
  s.homepage    = "https://github.com/coverhound/fixturator"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "railties", ">= 4.1.0", "< 6"

  s.add_development_dependency "mocha", "1.1"
  s.add_development_dependency "pry", "~> 0.10.3"
  s.add_development_dependency "sqlite3"
end
