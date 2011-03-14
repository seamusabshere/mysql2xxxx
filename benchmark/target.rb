#!/usr/bin/env ruby
require 'rubygems' unless RUBY_VERSION >= '1.9'
require 'memprof'
$LOAD_PATH.unshift File.join(ENV['HERE'], '..', 'lib')
require 'mysql2xxxx'

format = ARGV[0]

Memprof.track(ENV['MEMPROF_REPORT_PATH']) do
  a = Mysql2xxxx.const_get(format).new :user => ENV['DBUSER'], :password => ENV['DBPASSWORD'], :database => ENV['DBNAME'], :execute => ENV['EXECUTE']
  a.to_path ENV['DUMP_PATH']
end
