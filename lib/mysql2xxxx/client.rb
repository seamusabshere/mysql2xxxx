require 'mysql2'
module Mysql2xxxx
  class Client
    attr_reader :properties
    def initialize(properties)
      @properties = properties
    end
    def select_each(sql, &blk)
      mysql2.query(sql).each do |hsh|
        yield hsh
      end
    end
    private
    def mysql2
      @mysql2 ||= ::Mysql2::Client.new properties.database_config
    end
  end
end
