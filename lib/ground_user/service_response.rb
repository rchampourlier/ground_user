module GroundUser
  ServiceResponse = Struct.new(:status, :data, :errors) do

    def success?
      self.status == :success
    end

    def failure?
      self.status == :failure
    end
  end
end
