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
end if ::ActiveSupport::VERSION::MAJOR >= 3

# will use mysql2 as soon as :stream => true is supported
# https://github.com/brianmario/mysql2/pull/223
require 'mysql'

require 'mysql2xxxx/config'
require 'mysql2xxxx/writer'
require 'mysql2xxxx/writer/json'
require 'mysql2xxxx/writer/csv'
require 'mysql2xxxx/writer/xml'

module Mysql2xxxx
end
