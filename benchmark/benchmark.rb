#!/usr/bin/env ruby

ENV['HERE'] = File.dirname(__FILE__)
ENV['DBUSER'] = 'root'
ENV['DBPASSWORD'] = 'password'
ENV['DBNAME'] = 'data1'
ENV['MEMPROF_REPORT_PATH'] = File.expand_path('memprof.txt')
ENV['DUMP_PATH'] = File.expand_path('a.dump')
ENV['EXECUTE'] = 'SELECT * FROM five_thousand_rows'
FORMATS = %w{ CSV JSON XML }
SAMPLE_RATE = 0.3
TOP_OBJECTS = 25

require 'fileutils'
require 'rubygems' unless RUBY_VERSION >= '1.9'
require 'posix/spawn'
$LOAD_PATH.unshift File.join(ENV['HERE'], '..', 'lib')
require 'mysql2xxxx'
require 'mysql2xxxx/version'

$stderr.puts "Loading sample data..."
`bunzip2 #{ENV['HERE']}/five_thousand_rows.sql.bz2 -c | mysql -u #{ENV['DBUSER']} -p#{ENV['DBPASSWORD']} --database #{ENV['DBNAME']}`

now = Time.now
mem = {}
$mem2 = {}

begin
  FORMATS.each do |format|
    $stderr.puts "Benchmarking #{format}..."
    pid = POSIX::Spawn.spawn('ruby', "#{ENV['HERE']}/target.rb", format)
    watcher = Thread.new do
      while true
        sleep SAMPLE_RATE
        $mem2[format] ||= []
        $mem2[format] << `ps -o time= -o rss= -p #{pid}`
      end
    end
    Process.waitpid(pid)
    watcher.kill
    raise "target failed on #{format}" unless $?.success?
    mem[format] = IO.readlines(ENV['MEMPROF_REPORT_PATH'])[0..TOP_OBJECTS-1]
  end
ensure
  FileUtils.rm_f ENV['MEMPROF_REPORT_PATH']
  FileUtils.rm_f ENV['DUMP_PATH']
end

$stderr.puts "Writing report..."
File.open File.expand_path(File.join(ENV['HERE'], 'results', "#{Mysql2xxxx::VERSION}-#{now.to_formatted_s(:number)}.txt")), 'w' do |f|
  f.puts %{mysql2xxxx}
  f.puts %{Version: #{Mysql2xxxx::VERSION}}
  f.puts %{Run:     #{now}}
  f.puts %{System:  #{`uname -a`}}
  FORMATS.each do |format|
    f.puts
    f.puts "#" * 50
    f.puts "# #{format}"
    f.puts "#" * 50
    f.puts %{Real memory over time (sampled every #{SAMPLE_RATE} sec):}
    f.puts $mem2[format]
    f.puts %{Memprof object counts (top #{TOP_OBJECTS}):}
    f.puts mem[format]
  end
end
