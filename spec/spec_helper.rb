require 'pry'

ENV['APP_ENV'] = 'test'

root_dir = File.expand_path('../..', __FILE__)
$LOAD_PATH.unshift File.join(root_dir, 'lib', 'ground_user')

require File.join root_dir, 'config', 'boot'
require File.join root_dir, 'spec', 'support', 'shared_examples', 'service_response'

# Cleaning database after each test
RSpec.configure do |config|

  config.after(:each) do
    GroundUser::Persistence.delete_all
  end
end
