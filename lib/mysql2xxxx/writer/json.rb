require 'json'

module Mysql2xxxx
  class JSON < Writer
    def to_file(f)
      first = true
      f.write '['
      stream_hashes do |hsh|
        if first
          first = false
        else
          f.write ','
        end
        f.write ::JSON.generate(hsh)
      end
      f.write ']'
      nil
    end
  end
end
