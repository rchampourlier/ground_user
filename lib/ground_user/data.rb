module GroundUser
  Data = Struct.new(:id, :email, :hashed_password, :salt) do
  end
end
