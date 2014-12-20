require 'data'
require 'persistence'
require 'services/exist'
require 'utils/hash_password'
require 'utils/email_errors'
require 'utils/password_errors'

module GroundUser

  # Create a user with the specified email and password.
  #
  # @param email [String] must look like an email
  # @param password [String] min. 8 characters
  # @return [ServiceResponse]
  def create(email, password)
    CreateService.run(email, password)
  end
  module_function :create

  module CreateService

    def run(email, password)
      _errors = errors(email, password)
      return ServiceResponse.new(:failure, nil, _errors) if _errors.any?

      hashed_password, salt = Utils.hash_password(password)

      begin
        exist = Persistence.exist(email)
        return ServiceResponse.new(:failure, nil, [:existing_user_with_email]) if exist

      rescue Persistence::OperationFailure
        return ServiceResponse.new(:failure, nil, [:operation_failure])
      end

      begin
        data = Persistence.create(email, hashed_password, salt)
        return ServiceResponse.new(:success, data, [])

      rescue Persistence::OperationFailure
        return ServiceResponse.new(:failure, nil, [:save_failure])
      end
    end
    module_function :run

    def errors(email, password)
      (Utils.email_errors(email) + Utils.password_errors(password)).flatten.compact
    end
    module_function :errors
  end
end
