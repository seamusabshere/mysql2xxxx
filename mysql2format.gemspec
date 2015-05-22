# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mysql2xxxx/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "mysql2format"
  spec.version     = Mysql2Format::VERSION
  spec.authors     = ["Stanley Calixte"]
  spec.email       = ["ducalixte@gmail.com"]
  spec.homepage    = "https://github.com/scalixte-mdsol/mysql2format"
  spec.summary     = %q{In a memory-sensitive way (but not fast), dump mysql tables to JSON, CSV, XML.}
  spec.description = %q{Gives you binaries like mysql2csv, mysql2json, and mysql2xml, and Ruby classes to match.}

  spec.rubyforge_project = "mysql2format"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'activesupport', '~> 3.2'
  spec.add_dependency 'mysql2', '~> 0.3'
  spec.add_dependency 'mixlib-cli'
  spec.add_dependency 'fast_xs'
  spec.add_dependency 'fastercsv'
  spec.add_dependency 'multi_json'
  
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
