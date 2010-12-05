# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aperio/version"

Gem::Specification.new do |s|
  s.name        = "aperio"
  s.version     = Aperio::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Cook"]
  s.email       = ["cookrn@gmail.com"]
  s.homepage    = "https://github.com/cookrn/aperio"
  s.summary     = %q{An oauth2 provider engine for rails3 applications.}
  s.description = %q{An oauth2 provider engine for rails3 applications.}

  s.rubyforge_project = "aperio"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
