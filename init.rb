if RAILS_ENV == "test"
  require 'mhs_testing'
  config.after_initialize do
    require 'spec'
    require 'spec/rails'
    require File.join(RAILS_ROOT, *%w[vendor plugins mhs_testing lib selenium example_group])
    require 'spec/rails/story_adapter'
    require File.join(File.dirname(__FILE__), "lib", "selenium", "rails_selenium_story")
  end
end