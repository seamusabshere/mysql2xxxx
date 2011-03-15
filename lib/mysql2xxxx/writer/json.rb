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
        if RUBY_VERSION >= '1.9'
          # the mysql gem isn't encoding aware, so even if mysql returns proper utf-8, ruby 1.9 treats it as ASCII-8BIT
          # here we force ruby to treat these strings as utf-8 without any further conversion
          hsh.each { |k, v| hsh[k] = v.nil? ? nil : v.force_encoding(properties.encoding) }
        end
        f.write hsh.to_json
      end
      f.write ']'
      nil
    end
  end
end
