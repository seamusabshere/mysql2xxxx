require 'stringio'
require 'iconv'

module Mysql2xxxx
  class Writer
    MYSQL_CHARSET = 'utf8'
    ICONV_TO = 'UTF-8//TRANSLIT'
    ICONV_FROM = 'UTF-8'
    
    attr_reader :config
    
    def initialize(options = {})
      @config = Config.new options
    end
    
    def keys
      @keys ||= result.fetch_fields.map { |field| field.name }
    end
        
    def last_statement
      return @last_statement if @last_statement.is_a? ::String
      statements = config.execute.split(';').select { |statement| statement.to_s.strip.length > 0 }
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
      @dbh.options ::Mysql::SET_CHARSET_NAME, MYSQL_CHARSET
      @dbh.real_connect config.host, config.user, config.password, config.database, config.port, config.socket
      # so that we can use_result instead of store_result
      @dbh.query_with_result = false
      @dbh
    end

    def stream_arrays
      raise "dead connection" if @dead
      while ary = result.fetch_row do
        yield ary.map { |v| recode_as_utf8 v }
      end
      close
    end
    
    def stream_hashes
      raise "dead connection" if @dead
      while hsh = result.fetch_hash do
        yield hsh.inject({}) { |memo, (k, v)| memo[recode_as_utf8(k)] = recode_as_utf8(v); memo }
      end
      close
    end
    
    def recode_as_utf8(raw_str)
      return if raw_str.nil?
      [ iconv.iconv(raw_str), iconv.iconv(nil) ].join
    end
    
    def close
      @dead = true
      iconv.close
      result.free
      dbh.close
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
      f = ::RUBY_VERSION >= '1.9' ? ::File.open(path, 'w', :binmode => true) : ::File.open(path, 'w')
      to_file f
      f.close
      nil
    end
    
    private
    
    def iconv
      @iconv ||= ::Iconv.new(ICONV_TO, ICONV_FROM)
    end
  end
end
