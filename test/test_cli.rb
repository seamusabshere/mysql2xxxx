require 'helper'

class TestCli < Test::Unit::TestCase
  def test_xml
    a = POSIX::Spawn::Child.new %{mysql2xml --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.out.include?('Acura')
    assert !a.out.include?('DaimlerChrysler')
  end
  
  def test_json
    a = POSIX::Spawn::Child.new %{mysql2json --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.out.include?('Acura')
    assert !a.out.include?('DaimlerChrysler')
  end
  
  def test_csv
    a = POSIX::Spawn::Child.new %{mysql2csv --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.out.include?('Acura')
    assert !a.out.include?('DaimlerChrysler')
  end
end
