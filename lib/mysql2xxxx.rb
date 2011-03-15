unless RUBY_VERSION >= '1.9'
  $KCODE = 'U'
end
require 'active_support'
require 'active_support/version'
%w{
  active_support/core_ext/object
  active_support/core_ext/string
  active_support/core_ext/hash
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3
require 'mysql'

module Mysql2xxxx
  autoload :JSON, 'mysql2xxxx/writer/json'
  autoload :CSV, 'mysql2xxxx/writer/csv'
  autoload :XML, 'mysql2xxxx/writer/xml'
  autoload :Writer, 'mysql2xxxx/writer'
  autoload :Properties, 'mysql2xxxx/properties'
  autoload :Cli, 'mysql2xxxx/cli'
end
