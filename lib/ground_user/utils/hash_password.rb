module GroundUser
  module Utils

    def hash_password(password, salt = nil)
      salt ||= SecureRandom.base64(8)
      hashed_password = Digest::SHA2.hexdigest(salt + password)
      [hashed_password, salt]
    end
    module_function :hash_password
  end
end
