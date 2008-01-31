if RAILS_ENV == 'test'
  at_exit { Selenium::Server.disconnect! }
end
