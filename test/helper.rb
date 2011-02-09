require 'rubygems'
require 'bundler'
Bundler.setup
require 'test/unit'
require 'ruby-debug'
require 'fileutils'
require 'active_record'
require 'shell/executer'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mysql2xxxx'
class Test::Unit::TestCase
end

MYSQL_USER = 'root'
MYSQL_PASS = 'password'
TEST_DB = 'mysql2xxxx_test'

def execute_sql(sql, db = 'mysql')
  Shell.execute! %{mysql -u #{MYSQL_USER} -p#{MYSQL_PASS} --database="#{db}" --execute="#{sql}"}
end

execute_sql "DROP DATABASE IF EXISTS #{TEST_DB}"
execute_sql "CREATE DATABASE #{TEST_DB}"
execute_sql "SOURCE test/fixtures/automobile_makes.sql", TEST_DB
execute_sql "SOURCE test/fixtures/automobile_make_years.sql", TEST_DB

# just used as defaults
ActiveRecord::Base.establish_connection(
  'adapter' => 'mysql2',
  'database' => TEST_DB,
  'username' => MYSQL_USER,
  'password' => MYSQL_PASS
)
