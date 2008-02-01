require File.join(File.dirname(__FILE__), 'matchers')

# Spec::Runner.configure do |config|
#   config.include ValidationMatchers, AssociationMatchers
# end

require File.join(File.dirname(__FILE__), 'selenium')
require File.join(RAILS_ROOT, 'config', 'selenium', 'osx') if File.exist?(File.join(RAILS_ROOT, 'config', 'selenium', 'osx'))
