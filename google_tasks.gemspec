# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google_tasks/version"

Gem::Specification.new do |s|
  s.name        = "google_tasks"
  s.version     = GoogleTasks::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["DAddYE"]
  s.email       = ["d.dagostino@lipsiasoft.com"]
  s.homepage    = "https://github.com/daddye/google_tasks"
  s.summary     = %q{This gem provides access to google tasks apis}
  s.description = %q{This gem provides access to google tasks apis}

  s.rubyforge_project = "google_tasks"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end