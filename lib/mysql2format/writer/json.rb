require 'multi_json'

module Mysql2xxxx
  class JSON < Writer
    def to_file(f)
      first = true
      f.write '['
      client.query(last_statement, :stream => true, :cache_rows => false).each do |hsh|
        next if hsh.nil?
        if first
          first = false
        else
          f.write ','
        end
        f.write ::MultiJson.dump(hsh)
      end
      f.write ']'
      nil
    end
  end
end
