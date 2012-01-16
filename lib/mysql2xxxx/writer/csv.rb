if RUBY_VERSION >= '1.9'
  require 'csv'
else
  require 'fastercsv'
end

module Mysql2xxxx
  class CSV < Writer
    SLASH_N = '\N'.freeze
    def to_file(f)
      slash_n = config.slash_n

      if slash_n
        f.write keys.map { |v| v.nil? ? SLASH_N : v }.to_csv
      else
        f.write keys.to_csv
      end
      
      stream_arrays do |ary|
        if slash_n
          f.write ary.map { |v| v.nil? ? SLASH_N : v }.to_csv
        else
          f.write ary.to_csv
        end
      end
      nil
    end
  end
end
