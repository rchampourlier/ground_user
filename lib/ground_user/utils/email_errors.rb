module GroundUser
  module Utils
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def email_errors(email)
      return [:invalid_email] if email !~ VALID_EMAIL_REGEX
      []
    end
    module_function :email_errors
  end
end
