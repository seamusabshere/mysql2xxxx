source "http://rubygems.org"

gemspec

gem 'rake'
gem 'activerecord'
gem 'posix-spawn'

if RUBY_VERSION >= '1.9'
  gem 'ruby-debug19'
else
  if RUBY_PLATFORM != 'java'
    gem 'memprof'
  end
  gem 'ruby-debug'
end
