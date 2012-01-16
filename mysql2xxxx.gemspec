# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mysql2xxxx/version"

Gem::Specification.new do |s|
  s.name        = "mysql2xxxx"
  s.version     = Mysql2xxxx::VERSION
  s.platform    = Gem::Platform::RUBY
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
  
  s.add_dependency 'activesupport', '>=2.3.10'
  s.add_dependency 'mysql'
  s.add_dependency 'mixlib-cli'
  s.add_dependency 'fast_xs'
  s.add_dependency 'fastercsv'
  s.add_dependency 'json'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'shell-executer'
  s.add_development_dependency 'posix-spawn'
  if RUBY_VERSION >= '1.9'
    s.add_development_dependency 'ruby-debug19'
  else
    s.add_development_dependency 'memprof'
    s.add_development_dependency 'ruby-debug'
  end
end
