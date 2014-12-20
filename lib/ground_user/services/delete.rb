require 'data'
require 'persistence'

module GroundUser

  # Delete the user with the specified email.
  #
  # @param email [String]
  # @return [ServiceResponse]
  def delete(email)
    DeleteService.run(email)
  end
  module_function :delete

  module DeleteService

    def run(email)
      get_response = GroundUser.get(email)
      return get_response if get_response.failure?

      result = Persistence.delete(email)
      if result
        ServiceResponse.new(:success, get_response.data, [])
      else
        ServiceResponse.new(:failure, get_response.data, [:delete_failure])
      end
    end
    module_function :run
  end
end
