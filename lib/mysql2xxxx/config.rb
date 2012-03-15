module Mysql2xxxx
  class Config
    attr_reader :user_specified_options
    def initialize(user_specified_options = {})
      @user_specified_options = user_specified_options.symbolize_keys
    end
    
    def user
      user_specified_options[:user] || active_record_config.try(:[], :username)
    end
    
    def password
      user_specified_options[:password] || active_record_config.try(:[], :password)
    end
    
    def host
      user_specified_options[:host] || active_record_config.try(:[], :host)
    end
    
    def port
      user_specified_options[:port] || active_record_config.try(:[], :port)
    end
    
    def socket
      user_specified_options[:socket] || active_record_config.try(:[], :socket)
    end
    
    def database
      user_specified_options[:database] || active_record_connection.try(:current_database)
    end
    
    def execute
      user_specified_options[:execute]
    end
    
    # Whether to write \N instead of a blank string for NULL. This is helpful for mysqlimport.
    #
    # Only applies to CSV
    def slash_n
      user_specified_options.fetch :slash_n, false
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
