module Selenium
  module Assertions
    def assert_location(url)
      _execute_with_selenium('assert_location', url_for(url))
    end
    
    # Allow some methods to take multiple arguments
    [:visible, :text_present, :element_present, :editable].each do |assertion|
      define_method("assert_#{assertion}") do |*arguments|
        arguments.each { |a| _execute_with_selenium("assert_#{assertion}", a) }
      end
    end
    
    def wait_for_page_to_load(timeout = 5) # Default timeout
      _execute_with_selenium('wait_for_page_to_load', timeout * 1000)
    end
    
    def wait_for_pop_up(window_id, timeout = 5)
      _execute_with_selenium('wait_for_pop_up', window_id, timeout * 1000)
    end
  end
end
