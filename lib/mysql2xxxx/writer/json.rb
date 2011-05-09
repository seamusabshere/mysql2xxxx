%w{
  active_support/json/encoding
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3

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
        f.write hsh.to_json
      end
      f.write ']'
      nil
    end
  end
end
