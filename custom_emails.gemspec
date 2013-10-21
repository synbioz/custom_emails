$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "custom_emails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "custom_emails"
  s.version     = CustomEmails::VERSION
  s.authors     = ["Nicolas Zermati"]
  s.email       = ["nz@synbioz.com"]
  s.homepage    = "http://www.synbioz.com/"
  s.summary     = "CustomEmails add a few models and helpers to allow email content administration."
  s.description = "CustomEmails add a few models and helpers to allow email content administration."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
