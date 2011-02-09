module Mysql2xxxx
  class Properties
    attr_reader :options
    def initialize(options = {})
      @options = options.dup
      @options.stringify_keys!
    end
    
    def database_config
      {
        :username => database_username,
        :password => database_password,
        :host => database_host,
        :port => database_port,
        :database => database_name
      }
    end

    def database_username
      options['database_username'] || active_record_config.try(:[], :username)
    end
    
    def database_password
      options['database_password'] || active_record_config.try(:[], :password)
    end
    
    def database_host
      options['database_host'] || active_record_config.try(:[], :host)
    end
    
    def database_port
      options['database_port'] || active_record_config.try(:[], :port)
    end
    
    def database_name
      options['database_name'] || active_record_connection.try(:current_database)
    end
    
    def sql
      options['sql']
    end
        
    private
    
    def active_record_connection
      if defined? ::ActiveRecord
        ::ActiveRecord::Base.connection
      end
    end
    
    def active_record_config
      if active_record_connection
        active_record_connection.instance_variable_get :@config
      end
    end
  end
end
