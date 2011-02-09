require 'stringio'
module Mysql2xxxx
  module ExtraOutputs
    def to_s
      s = ::StringIO.new
      to_file s
      s.rewind
      s.read
    end
    
    def to_stdout
      to_file $stdout
      nil
    end
    
    def to_path(path)
      f = ::File.open(path, 'w')
      to_file f
      f.close
      nil
    end
  end
end
