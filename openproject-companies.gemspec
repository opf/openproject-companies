# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/companies/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-companies"
  s.version     = OpenProject::Companies::VERSION
  s.authors     = "OpenProject GmbH"
  s.email       = "info@openproject.org"
  s.homepage    = "https://community.openproject.org/projects/companies"  # TODO check this URL
  s.summary     = 'OpenProject Companies'
  s.description = "Adds stuff relating to companies."
  s.license     = "GPLv3" # e.g. "MIT" or "GPLv3"

  s.files = Dir["{app,config,db,lib}/**/*"] + %w(CHANGELOG.md README.md)

  s.add_dependency "rails", "~> 5.0"
end
