require 'helper'

class TestMysql2xxxx < Test::Unit::TestCase
  def setup
    @sql = %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)}
  end
  
  def test_mysql2json
    a = Mysql2xxxx::JSON.new :sql => @sql
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')    
  end

  def test_mysql2csv
    a = Mysql2xxxx::CSV.new :sql => @sql
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')    
  end
  
  def test_mysql2xml
    a = Mysql2xxxx::XML.new :sql => @sql
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')    
  end
end
