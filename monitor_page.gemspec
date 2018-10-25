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
  s.summary     = "A gem to view status checks of multiple services from a single page."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
end
