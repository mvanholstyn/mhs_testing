module Selenium
  module Helpers
    def login(login = "quentin", password = "test")
      open login_path
      type "login", login
      type "password", password
      click_and_wait "commit"
    end

    def open_and_wait(url, timeout = 30)
      open url
      wait_for_page_to_load(timeout)
    end

    def click_and_wait(locator, timeout = 30)
      click locator
      wait_for_page_to_load(timeout)
    end

    def refresh_and_wait(timeout = 30)
      refresh
      wait_for_page_to_load(timeout)
    end

    def see_element(*args)
      assert is_element_present("css=#{args.join}")
    end

    def dont_see_element(*args)
      assert !is_element_present("css=#{args.join}")
    end

    def assert_visible(locator)
      assert is_visible(locator)
    end

    def assert_not_visible(locator)
      assert !is_visible(locator)
    end

    def assert_element_disabled(selector)
      see_element("#{selector}[disabled]")
    end

    def assert_element_enabled(selector)
      dont_see_element("#{selector}[disabled]")
    end
  end
end