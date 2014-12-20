require 'data'
require 'persistence'

module GroundUser

  # Find the user with the specified email.
  #
  # @param email [String]
  # @return [ServiceResponse]
  def verify_password(email, password)
    VerifyPasswordService.run(email, password)
  end
  module_function :verify_password

  module VerifyPasswordService

    def run(email, password)
      persisted_user = (
        begin
          Persistence.get(email)
        rescue Persistence::NotFound
          return ServiceResponse.new(:failure, nil, [:not_found]) if persisted_user.nil?
        end
      )

      hashed_password, _salt = Utils.hash_password(password, persisted_user.salt)
      result = hashed_password == persisted_user.hashed_password

      ServiceResponse.new(:success, result, [])
    end
    module_function :run
  end
end
