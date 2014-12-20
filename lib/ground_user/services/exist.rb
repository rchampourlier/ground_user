require 'data'
require 'persistence'

module GroundUser

  # Find the user with the specified email.
  #
  # @param email [String]
  # @return [ServiceResponse]
  def exist(email)
    ExistService.run(email)
  end
  module_function :exist

  module ExistService

    def run(email)
      persisted_user = (
        begin
          Persistence.exist(email)

        rescue Persistence::OperationFailure
          return ServiceResponse.new(:failure, nil, [:operation_failure])
        end
      )

      ServiceResponse.new(:success, !!persisted_user, [])
    end
    module_function :run
  end
end
