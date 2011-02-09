require 'helper'

class TestCli < Test::Unit::TestCase
  def test_xml
    a = Shell.execute! %{mysql2xml --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.stdout.include?('Acura')
    assert !a.stdout.include?('DaimlerChrysler')
  end
  
  def test_json
    a = Shell.execute! %{mysql2json --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.stdout.include?('Acura')
    assert !a.stdout.include?('DaimlerChrysler')
  end
  
  def test_csv
    a = Shell.execute! %{mysql2csv --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    assert a.stdout.include?('Acura')
    assert !a.stdout.include?('DaimlerChrysler')
  end
end
