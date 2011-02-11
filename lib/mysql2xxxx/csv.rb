if RUBY_VERSION >= '1.9'
  require 'csv'
else
  require 'fastercsv'
end

module Mysql2xxxx
  class CSV
    include ExtraOutputs
    
    attr_reader :properties
    
    def initialize(options = {})
      @properties = Properties.new options
    end
    
    def to_file(f)
      keys = nil

      @client = ::Mysql2::Client.new properties.database_config
      parts = properties.execute.split(';')
      parts[0..-2].each do |part|
        @client.query part
      end
      @client.query(parts.last).each do |hsh|
        unless keys
          keys = hsh.keys
          f.write keys.to_csv
        end
        f.write keys.inject([]) { |memo, k| memo.push hsh[k] }.to_csv
      end

      nil
    ensure
      @client.try :close
    end
  end
end
