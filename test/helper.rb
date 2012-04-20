require 'rubygems'
require 'bundler'
Bundler.setup

if ::Bundler.definition.specs['debugger'].first
  require 'debugger'
elsif ::Bundler.definition.specs['ruby-debug'].first
  require 'ruby-debug'
end

require 'test/unit'
require 'fileutils'
require 'active_record'
require 'posix/spawn'
require 'mysql2xxxx'

MYSQL_USER = 'root'
MYSQL_PASS = 'password'
MYSQL_HOST = '127.0.0.1'
TEST_DB = 'mysql2xxxx_test'

def execute_sql(sql, db = 'mysql')
  POSIX::Spawn::Child.new %{mysql -u #{MYSQL_USER} -p#{MYSQL_PASS} --database="#{db}" --execute="#{sql}"}
end

execute_sql "DROP DATABASE IF EXISTS #{TEST_DB}"
execute_sql "CREATE DATABASE #{TEST_DB}"
execute_sql "SOURCE test/fixtures/automobile_makes.sql", TEST_DB
execute_sql "SOURCE test/fixtures/automobile_make_years.sql", TEST_DB

class Test::Unit::TestCase
  def setup
    @options = {
      :execute => %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)},
      :user => MYSQL_USER,
      :password => MYSQL_PASS,
      :database => TEST_DB,
      :host => MYSQL_HOST
    }
  end
end
