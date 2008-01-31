module Selenium
  class Configuration
    attr_accessor :options, :browsers
    
    def initialize
      @options = {
        :selenium_server_host  => 'localhost',
        :selenium_server_port  => 4444,
        :start_selenium_server => true,
        :test_server_host      => 'localhost',
        :test_server_port      => 3001,
        :start_test_server     => true
      }
      @browsers = []
    end
    
    def method_missing(method_id, *arguments)
      method_name = method_id.to_s
      
      if md = /=$/.match(method_name)
        options[md.pre_match.to_sym] = arguments.first
      else
        options[method_name.gsub(/\?$/, '').to_sym]
      end
    end

    def browser(*args)
      browsers << Browser.new(*args)
    end
  end
end