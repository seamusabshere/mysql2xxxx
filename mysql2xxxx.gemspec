# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mysql2xxxx/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mysql2xxxx"
  s.version     = Mysql2xxxx::VERSION
  s.authors     = ["Seamus Abshere"]
  s.email       = ["seamus@abshere.net"]
  s.homepage    = "https://github.com/seamusabshere/mysql2xxxx"
  s.summary     = %q{In a memory-sensitive way (but not fast), dump mysql tables to JSON, CSV, XML.}
  s.description = %q{Gives you binaries like mysql2csv, mysql2json, and mysql2xml, and Ruby classes to match.}

  s.rubyforge_project = "mysql2xxxx"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'activesupport', '>=3.1'
  s.add_dependency 'mysql2', '>=0.3'
  s.add_dependency 'mixlib-cli'
  s.add_dependency 'fast_xs'
  s.add_dependency 'fastercsv'
  s.add_dependency 'multi_json'
end
