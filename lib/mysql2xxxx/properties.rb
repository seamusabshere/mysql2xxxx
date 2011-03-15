module Mysql2xxxx
  class Properties
    attr_reader :options
    def initialize(options = {})
      @options = options.dup
      @options.stringify_keys!
    end
    
    def user
      options['user'] || active_record_config.try(:[], :username)
    end
    
    def password
      options['password'] || active_record_config.try(:[], :password)
    end
    
    def host
      options['host'] || active_record_config.try(:[], :host) || '127.0.0.1'
    end
    
    # Force utf8 as mysql connection charset
    def charset
      'utf8'
    end
    
    # Force UTF-8 as ruby string encoding (ruby 1.9 only)
    def encoding
      'UTF-8'
    end
    
    def port
      options['port'] || active_record_config.try(:[], :port)
    end
    
    def socket
      options['socket'] || active_record_config.try(:[], :socket)
    end
    
    def database
      options['database'] || active_record_connection.try(:current_database)
    end
    
    def execute
      options['execute']
    end
        
    private
    
    def active_record_connection
      if defined?(::ActiveRecord)
        ::ActiveRecord::Base.connection
      end
    rescue
      # oh well
    end
    
    def active_record_config
      if active_record_connection
        active_record_connection.instance_variable_get :@config
      end
    end
  end
end
