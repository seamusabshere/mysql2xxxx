require 'helper'

%w{
  active_support/json
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3

if RUBY_VERSION >= '1.9'
  require 'csv'
else
  require 'fastercsv'
end

class TestWellFormedness < Test::Unit::TestCase
  def test_xml
    a = Shell.execute! %{mysql2xml --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    funny_looking_hash = Hash.from_xml a.stdout
    assert funny_looking_hash['resultset']['row'].one? { |hsh| hsh['field'][0] == 'Yugo' }
  end
  
  def test_json
    a = Shell.execute! %{mysql2json --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    array_of_hashes = ActiveSupport::JSON.decode a.stdout
    assert array_of_hashes.one? { |hsh| hsh['name'] == 'Yugo' }
  end
  
  def test_csv
    a = Shell.execute! %{mysql2csv --user=#{@options[:user]} --password=#{@options[:password]} --database=#{@options[:database]} --execute="#{@options[:execute]}"}
    found_yugo = false
    (defined?(FasterCSV) ? FasterCSV : CSV).parse(a.stdout, :headers => :first_row) do |row|
      found_yugo = true if row['name'] == 'Yugo'
    end
    assert found_yugo
  end
end
