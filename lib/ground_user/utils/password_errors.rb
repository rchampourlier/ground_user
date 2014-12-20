module GroundUser
  module Utils

    def password_errors(password)
      return [:password_too_short] if password.length <= 7
      []
    end
    module_function :password_errors
  end
end

