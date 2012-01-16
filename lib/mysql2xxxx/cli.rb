require 'mixlib/cli'

module Mysql2xxxx
  class Cli
    include ::Mixlib::CLI
    %w{ user password host Port database }.each do |o|
      option o.downcase.to_sym,
        :short => "-#{o[0,1]} #{o.upcase}",
        :long  => "--#{o.downcase}=#{o.upcase}",
        :description => "Set MySQL #{o.downcase}"
    end
    option :execute,
      :short => '-e EXECUTE',
      :long  => '--execute=EXECUTE',
      :description => 'The SQL statement to execute'
    option :help,
      :long => "--help",
      :description => "Show this message",
      :on => :tail,
      :boolean => true,
      :show_options => true,
      :exit => 0
  end
end
