$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "monitor_page/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "monitor_page"
  s.version     = MonitorPage::VERSION
  s.authors     = ["Chris Gooley"]
  s.email       = ["chris@gooddogdesign.com"]
  s.homepage    = ""
  s.summary     = "Generates a page with a configurable set of status checks"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
end
