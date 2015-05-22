require 'helper'

# just to be able to steal the config
ActiveRecord::Base.establish_connection(
  'adapter' => 'mysql2',
  'database' => TEST_DB,
  'username' => MYSQL_USER,
  'password' => MYSQL_PASS
)

class TestActiveRecordConfigStealing < Test::Unit::TestCase
  def test_steals_config
    a = Mysql2format::JSON.new @options.slice(:execute)
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')
  end
end
