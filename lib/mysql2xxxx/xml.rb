require 'builder'

module Mysql2xxxx
  class XML
    include ExtraOutputs
    
    attr_reader :properties
    
    def initialize(options = {})
      @properties = Properties.new options
    end
    
    def client
      @client ||= Client.new properties
    end

    def to_file(f)
      xml = ::Builder::XmlMarkup.new :target => f
      xml.resultset :statement => properties.sql
      client.select_each(properties.sql) do |hsh|
        xml.tag! :row do
          hsh.each do |k, v|
            if v.nil?
              xml.tag! :field, :name => k, 'xsi:nil' => 'true'
            else
              xml.tag! :field, v, :name => k
            end
          end
        end
      end
      nil
    end
  end
end
