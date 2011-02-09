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
    
    def client
      @client ||= Client.new properties
    end

    def to_file(f)
      first = true
      f.write '['
      client.select_each(properties.execute) do |hsh|
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
    end
  end
end
