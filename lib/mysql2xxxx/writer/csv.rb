if RUBY_VERSION >= '1.9'
  require 'csv'
else
  require 'fastercsv'
end

module Mysql2xxxx
  class CSV < Writer
    def to_file(f)
      f.write keys.to_csv
      stream_arrays do |ary|
        f.write ary.to_csv
      end
      nil
    end
  end
end
