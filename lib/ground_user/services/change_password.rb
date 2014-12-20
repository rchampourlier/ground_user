require 'data'
require 'persistence'
require 'utils/password_errors'

module GroundUser

  # Find the user with the specified email.
  #
  # @param email [String]
  # @return [ServiceResponse]
  def change_password(email, password)
    ChangePasswordService.run(email, password)
  end
  module_function :change_password

  module ChangePasswordService

    def run(email, password)
      password_errors = Utils.password_errors(password)
      return ServiceResponse.new(:failure, nil, password_errors) if password_errors.any?

      hashed_password, salt = Utils.hash_password(password)
      data = (
        begin
          Persistence.update(email, hashed_password, salt)
        rescue Persistence::NotFound
          return ServiceResponse.new(:failure, nil, [:not_found])
        rescue Persistence::OperationFailure
          return ServiceResponse.new(:failure, nil, [:save_failure])
        end
      )

      ServiceResponse.new(:success, data, [])
    end
    module_function :run
  end
end
