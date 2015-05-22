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

      result = client.query(last_statement, :stream => true, :cache_rows => false, :as => :array)
      fields = result.fields

      if slash_n
        f.write fields.map { |v| v.nil? ? SLASH_N : v }.to_csv
      else
        f.write fields.to_csv
      end
      
      result.each do |ary|
        next if ary.nil?
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
