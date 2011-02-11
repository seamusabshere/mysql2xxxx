%w{
  active_support/json/encoding
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3

module Mysql2xxxx
  class JSON
    include ExtraOutputs
    
    attr_reader :properties
    
    def initialize(options = {})
      @properties = Properties.new options
    end
    
    def to_file(f)
      first = true
      f.write '['
      
      @client = ::Mysql2::Client.new properties.database_config
      parts = properties.execute.gsub(/\s+/, ' ').strip.chomp(';').split(';')
      parts[0..-2].each do |part|
        @client.query part
      end
      @client.query(parts.last).each do |hsh|
        line = if first
          first = false
          hsh.to_json
        else
          ',' + hsh.to_json
        end
        f.write line
      end
      
      f.write ']'
      nil
    ensure
      @client.try :close
    end
  end
end
