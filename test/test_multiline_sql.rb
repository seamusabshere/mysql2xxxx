require 'helper'

class TestMultilineSql < Test::Unit::TestCase
  def test_multiline_sql
    a = Mysql2xxxx::JSON.new @options.merge(:execute => %{DROP TABLE IF EXISTS t1; CREATE TEMPORARY TABLE t1 SELECT CONCAT_WS('-', year, make_name) AS crazy_name FROM automobile_make_years; SELECT * FROM t1;})
    str = a.to_s
    assert str.include?('2002-Acura')
  end
end
