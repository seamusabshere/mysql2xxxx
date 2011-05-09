# coding: utf-8
require 'helper'

class TestMysql2xxxx < Test::Unit::TestCase
  def test_1_mysql2json
    a = Mysql2xxxx::JSON.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert str.include?(%q{Citro\u00ebn})
    assert !str.include?('DaimlerChrysler')
  end

  def test_2_mysql2csv
    a = Mysql2xxxx::CSV.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert str.include?('Citroën')
    assert !str.include?('DaimlerChrysler')
  end
  
  def test_3_mysql2xml
    a = Mysql2xxxx::XML.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert str.include?('Citro&#235;n')
    assert !str.include?('DaimlerChrysler')
  end
end
