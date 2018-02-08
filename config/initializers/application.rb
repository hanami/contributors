require 'dry/system/container'

# Configure the code that will yield each time Admin::Action is included
# This is useful for sharing common functionality
#
# See: http://www.rubydoc.info/gems/hanami-controller#Configuration
ADMIN_USERNAME = ENV.fetch('ADMIN_USERNAME')
ADMIN_PASSWORD = ENV.fetch('ADMIN_PASSWORD')

class Application < Dry::System::Container
  configure
end
