require 'data'
require 'persistence'

module GroundUser

  # Find the user with the specified email.
  #
  # @param email [String]
  # @return [ServiceResponse]
  def get(email)
    GetService.run(email)
  end
  module_function :get

  module GetService

    def run(email)
      data = (
        begin
          Persistence.get(email)
        rescue Persistence::NotFound
          return ServiceResponse.new(:failure, nil, [:not_found])
        end
      )

      ServiceResponse.new(:success, data, [])
    end
    module_function :run
  end
end
