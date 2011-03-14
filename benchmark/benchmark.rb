#!/usr/bin/env ruby

ENV['HERE'] = File.dirname(__FILE__)
ENV['DBUSER'] = 'root'
ENV['DBPASSWORD'] = 'password'
ENV['DBNAME'] = 'data1'
ENV['MEMPROF_REPORT_PATH'] = File.expand_path('memprof.txt')
ENV['DUMP_PATH'] = File.expand_path('a.dump')
ENV['EXECUTE'] = 'SELECT * FROM five_thousand_rows'
FORMATS = %w{ CSV JSON XML }

require 'benchmark'
require 'rubygems' unless RUBY_VERSION >= '1.9'
require 'posix/spawn'
$LOAD_PATH.unshift File.join(ENV['HERE'], '..', 'lib')
require 'mysql2xxxx'
require 'mysql2xxxx/version'

$stderr.puts "Loading sample data..."
`bunzip2 #{ENV['HERE']}/five_thousand_rows.sql.bz2 -c | mysql -u #{ENV['DBUSER']} -p#{ENV['DBPASSWORD']} --database #{ENV['DBNAME']}`

now = Time.now
mem = {}
time = {}

FORMATS.each do |format|
  $stderr.puts "Benchmarking #{format}..."
  time[format] = Benchmark.realtime do
    pid = POSIX::Spawn.spawn('ruby', "#{ENV['HERE']}/target.rb", format)
    stat = Process::waitpid(pid)
  end
  mem[format] = IO.readlines(ENV['MEMPROF_REPORT_PATH'])[0..9]
end

File.unlink ENV['MEMPROF_REPORT_PATH']
File.unlink ENV['DUMP_PATH']

$stderr.puts "Writing report..."
File.open File.expand_path(File.join(ENV['HERE'], 'results', "#{Mysql2xxxx::VERSION}-#{now.to_formatted_s(:number)}.txt")), 'w' do |f|
  f.puts %{mysql2xxxx}
  f.puts %{Version: #{Mysql2xxxx::VERSION}}
  f.puts %{Run:     #{now}}
  f.puts %{System:  #{`uname -a`}}
  FORMATS.each do |format|
    f.puts
    f.puts format
    f.puts %{Time: #{time[format]}}
    f.puts %{Memory:}
    f.puts mem[format]
  end
end
