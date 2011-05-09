require 'stringio'
if ::RUBY_VERSION >= '1.9'
  require 'ensure/encoding'
else
  require 'iconv'
end

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
      if ::RUBY_VERSION >= '1.9'
        $stderr.puts "[mysql2xxxx] Raw - #{raw_str}" if ::ENV['MYSQL2XXXX_DEBUG'] == 'true'
        recoded_str = raw_str.ensure_encoding 'UTF-8', :external_encoding => properties.encoding, :invalid_characters => :transcode
        $stderr.puts "[mysql2xxxx] Recoded - #{recoded_str}" if ::ENV['MYSQL2XXXX_DEBUG'] == 'true'
        recoded_str
      else
        $stderr.puts "[mysql2xxxx] Raw - #{raw_str}" if ::ENV['MYSQL2XXXX_DEBUG'] == 'true'
        recoded_str = ::Iconv.conv('UTF-8//TRANSLIT', properties.encoding, raw_str.to_s + ' ')[0..-2]
        $stderr.puts "[mysql2xxxx] Recoded - #{recoded_str}" if ::ENV['MYSQL2XXXX_DEBUG'] == 'true'
        recoded_str
      end
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
