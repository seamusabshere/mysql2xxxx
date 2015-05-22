# coding: utf-8
require 'helper'

class TestMysql2xxxx < Test::Unit::TestCase
  def test_1_mysql2json
    a = Mysql2format::JSON.new @options
    str = a.to_s
    assert str.include?('Acura')
    if RUBY_VERSION >= '1.9'
      assert str.include?('Citro\u00ebn')
    else
      assert str.include?('Citroën')
    end
    assert !str.include?('DaimlerChrysler')
  end

  def test_2_mysql2csv
    a = Mysql2format::CSV.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert str.include?('Citroën')
    assert !str.include?('DaimlerChrysler')
  end
  
  def test_3_mysql2xml
    a = Mysql2format::XML.new @options
    str = a.to_s
    assert str.include?('Acura')
    assert str.include?('Citro&#235;n')
    assert !str.include?('DaimlerChrysler')
  end
  
  def test_4_slash_n_for_nulls
    a = Mysql2format::CSV.new @options
    assert a.to_s.include?(',,')
    b = Mysql2format::CSV.new @options.merge(:slash_n => true)
    assert b.to_s.include?(',\N,')
  end
end
