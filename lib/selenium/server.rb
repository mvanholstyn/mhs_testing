module Selenium
  class Server
    class << self
      def connect!(options = {})
        configuration = Selenium.configuration

        if configuration.start_test_server? && !@test_server
          @test_server = SubProcess.start "mongrel_rails start -c #{RAILS_ROOT} -e test -p #{configuration.test_server_port}"
          # sleep(5)
        end
      
        if configuration.start_selenium_server? && !@selenium_server
          server_path = File.expand_path(File.join(File.dirname(__FILE__), "selenium-server.jar"))
          @selenium_server = SubProcess.start "java -jar #{server_path} -port #{configuration.selenium_server_port}"
          sleep(2)
        end
      end
    
      def disconnect!
        configuration = Selenium.configuration
      
        if configuration.start_test_server? && @test_server
          @test_server.stop
          @test_server = nil
        end
      
        if configuration.start_selenium_server? && @selenium_server
          @selenium_server.stop
          @selenium_server = nil
        end
      end
    end
  end
end