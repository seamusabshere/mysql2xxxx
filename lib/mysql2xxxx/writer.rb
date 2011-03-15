require 'stringio'
module Mysql2xxxx
  class Writer
    attr_reader :properties
    
    def initialize(options = {})
      @properties = Properties.new options
    end
    
    def keys
      @keys ||= result.fetch_fields.map { |field| field.name }
    end
        
    def last_statement
      return @last_statement if @last_statement.is_a? ::String
      statements = properties.execute.split(';').select { |statement| statement.to_s.strip.length > 0 }
      @last_statement = statements.pop
      statements.each do |statement|
        dbh.query statement
        # but we're not using the results
      end
      @last_statement
    end
    
    def result
      return @result if @result.is_a? ::Mysql::Result
      dbh.query last_statement
      @result = dbh.use_result
    end
    
    def dbh
      return @dbh if @dbh.is_a? ::Mysql
      @dbh = ::Mysql.init
      @dbh.options ::Mysql::SET_CHARSET_NAME, properties.charset
      @dbh.real_connect properties.host, properties.user, properties.password, properties.database, properties.port, properties.socket
      # so that we can use_result instead of store_result
      @dbh.query_with_result = false
      @dbh
    end

    def stream_arrays
      raise "dead connection" if @dead
      while ary = result.fetch_row do
        yield ary
      end
      close
    end
    
    def stream_hashes
      raise "dead connection" if @dead
      while hsh = result.fetch_hash do
        yield hsh
      end
      close
    end
    
    def close
      result.free
      dbh.close
      @dead = true
    end
    
    def to_s
      s = ::StringIO.new
      to_file s
      s.rewind
      s.read
    end
    
    def to_stdout
      to_file $stdout
      nil
    end
    
    def to_path(path)
      f = ::File.open(path, 'w')
      to_file f
      f.close
      nil
    end
  end
end
