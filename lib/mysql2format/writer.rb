require 'stringio'

module Mysql2xxxx
  class Writer
    attr_reader :config
    
    def initialize(options = {})
      @config = Config.new options
    end
    
    def last_statement
      return @last_statement if @last_statement.is_a? ::String
      statements = config.execute.split(';').select { |statement| statement.to_s.strip.length > 0 }
      last_statement = statements.pop
      statements.each do |statement|
        client.query statement
        # but we're not using the results, of course
      end
      @last_statement = last_statement
    end
        
    def client
      return @client if @client.is_a? ::Mysql2::Client
      @client = ::Mysql2::Client.new(:host => config.host, :username => config.user, :password => config.password, :database => config.database, :port => config.port, :socket => config.socket)
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
  end
end
