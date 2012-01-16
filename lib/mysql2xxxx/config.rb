module Mysql2xxxx
  class Config
    attr_reader :options
    def initialize(options = {})
      @options = options.symbolize_keys
    end
    
    def user
      options[:user] || active_record_config.try(:[], :username)
    end
    
    def password
      options[:password] || active_record_config.try(:[], :password)
    end
    
    def host
      options[:host] || active_record_config.try(:[], :host)
    end
    
    # MySQL connection charset
    #
    # If you change this, you also have to change :encoding
    #
    # Default: utf8
    def charset
      options[:charset] || 'utf8'
    end
    
    # Encoding
    #
    # If you change this, you also have to change :charset
    #
    # Default: UTF-8
    def encoding
      options[:encoding] || 'UTF-8'
    end
    
    def port
      options[:port] || active_record_config.try(:[], :port)
    end
    
    def socket
      options[:socket] || active_record_config.try(:[], :socket)
    end
    
    def database
      options[:database] || active_record_connection.try(:current_database)
    end
    
    def execute
      options[:execute]
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
