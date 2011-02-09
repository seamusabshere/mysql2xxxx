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
    
    def client
      @client ||= Client.new properties
    end

    def to_file(f)
      keys = nil
      client.select_each(properties.sql) do |hsh|
        unless keys
          keys = hsh.keys
          f.write keys.to_csv
        end
        f.write keys.inject([]) { |memo, k| memo.push hsh[k] }.to_csv
      end
      nil
    end
  end
end
