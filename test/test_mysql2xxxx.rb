require 'helper'

class TestMysql2xxxx < Test::Unit::TestCase
  def test_mysql2json
    a = Mysql2xxxx::JSON.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')
  end

  def test_mysql2csv
    a = Mysql2xxxx::CSV.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')
  end
  
  def test_mysql2xml
    a = Mysql2xxxx::XML.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')
  end
end
