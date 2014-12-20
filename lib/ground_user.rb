$LOAD_PATH.unshift File.expand_path('../ground_user', __FILE__)

module GroundUser
  require 'service_response'
  require 'services/create'
  require 'services/get'
  require 'services/change_password'
  require 'services/verify_password'
  require 'services/delete'
end

$LOAD_PATH.shift
