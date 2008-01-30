require File.join(File.dirname(__FILE__), 'matchers')

Spec::Runner.configure do |config|
  config.include ValidationMatchers, AssociationMatchers
end
