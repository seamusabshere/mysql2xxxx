require 'helper'

class TestExtraOutputs < Test::Unit::TestCase
  def test_mysql2json_to_s
    a = Mysql2xxxx::JSON.new :sql => %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)}
    str = a.to_s
    assert str.include?('Acura')
    assert !str.include?('DaimlerChrysler')    
  end
  
  def test_mysql2json_to_path
    path = '/tmp/test_mysql2json_to_path'
    a = Mysql2xxxx::JSON.new :sql => %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)}
    a.to_path path
    assert File.read(path).include?('Acura')
    assert !File.read(path).include?('DaimlerChrysler')
  end
  
  def test_mysql2json_to_file
    f = File.open('/tmp/test_mysql2json_to_file', 'w')
    a = Mysql2xxxx::JSON.new :sql => %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)}
    a.to_file f
    f.close
    assert File.read(f.path).include?('Acura')
    assert !File.read(f.path).include?('DaimlerChrysler')
  end
  
  def test_mysql2json_to_stdout
    a = Mysql2xxxx::JSON.new :sql => %{SELECT * FROM automobile_makes WHERE automobile_makes.name IN (SELECT DISTINCT automobile_make_years.make_name FROM automobile_make_years)}
    begin
      require 'stringio'
      old_stdout = $stdout
      my_stdout = StringIO.new
      $stdout = my_stdout
      a.to_stdout
      $stdout = old_stdout
      my_stdout.rewind
      assert my_stdout.read.include?('Acura')
      assert !my_stdout.read.include?('DaimlerChrysler')
    ensure
      $stdout = old_stdout
    end
  end
end
