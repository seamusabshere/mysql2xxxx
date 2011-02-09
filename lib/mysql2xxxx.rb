require 'active_support'
require 'active_support/version'
%w{
  active_support/core_ext/object
  active_support/core_ext/string
  active_support/core_ext/hash
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3

module Mysql2xxxx
  autoload :JSON, 'mysql2xxxx/json'
  autoload :CSV, 'mysql2xxxx/csv'
  autoload :XML, 'mysql2xxxx/xml'
  autoload :Properties, 'mysql2xxxx/properties'
  autoload :Client, 'mysql2xxxx/client'
  autoload :ExtraOutputs, 'mysql2xxxx/extra_outputs'
  autoload :Cli, 'mysql2xxxx/cli'
end
