unless RUBY_VERSION >= '1.9'
  $KCODE = 'U'
end
require 'active_support'
require 'active_support/version'
require 'active_support/core_ext' if ::ActiveSupport::VERSION::MAJOR >= 3

require 'mysql2'

require 'mysql2xxxx/config'
require 'mysql2xxxx/writer'
require 'mysql2xxxx/writer/json'
require 'mysql2xxxx/writer/csv'
require 'mysql2xxxx/writer/xml'

module Mysql2xxxx
end
