$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zapier_rest_hooks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zapier_rest_hooks"
  s.version     = ZapierRestHooks::VERSION
  s.authors     = ["Esteban Arango Medina"]
  s.email       = ["marranoparael31@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of ZapierRestHooks."
  s.description = "Integration of Zapier REST hooks pattern within a Ruby on Rails app."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency('rest-client', '~> 1.8')

  s.add_development_dependency "rspec-rails", "~> 3.4"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency 'factory_girl_rails', '~> 4.7'
end
