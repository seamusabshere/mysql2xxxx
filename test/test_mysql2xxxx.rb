# coding: utf-8
require 'helper'

class TestMysql2xxxx < Test::Unit::TestCase
  def test_1_mysql2json
    a = Mysql2xxxx::JSON.new @options
    str = a.to_s
    assert str.include?('Acura')
    # active_support/json encodes non-ascii with \u sequences even though it's not necessary
    assert str.include?('Citro\u00ebn')
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
  
  def test_4_slash_n_for_nulls
    a = Mysql2xxxx::CSV.new @options
    assert a.to_s.include?(',,')
    b = Mysql2xxxx::CSV.new @options.merge(:slash_n => true)
    assert b.to_s.include?(',\N,')
  end
end
