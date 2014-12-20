require 'mongoid'
require 'data'

module GroundUser
  module Persistence

    OperationFailure = Class.new(StandardError)
    NotFound = Class.new(StandardError)

    # @return [GroundUser::Data] if the creation succeeded
    # @raise OperationFailure if the user could not be created
    def create(email, hashed_password, salt)
      document = Document.create(
        email: email,
        hashed_password: hashed_password,
        salt: salt
      )
      raise OperationFailure if document.new_record?

      document.build_data
    end
    module_function :create

    # @return [Bool] true if an user with the specified email could
    #   be found
    def exist(email)
      Document.where(email: email).count > 0
    end
    module_function :exist

    # @return [GroundUser::Data] if the user could be found
    # @raise NotFound if the user could not be found
    def get(email)
      document = get_document(email)
      raise NotFound if document.nil?

      document.build_data
    end
    module_function :get

    # @return [GroundUser::Data] if the update succeeded
    # @raise OperationFailure if the user could not be updated
    # @raise NotFound if the user could not be found
    def update(email, hashed_password, salt)
      document = get_document(email)
      raise NotFound if document.nil?

      update_result = document.update_attributes(
        hashed_password: hashed_password,
        salt: salt
      )
      raise OperationFailure if update_result == false

      document.build_data
    end
    module_function :update

    # @return [GroundUser::Data] if the update succeeded
    # @raise OperationFailure if the user could not be updated
    # @raise NotFound if the user could not be found
    def delete(email)
      document = get_document(email)
      raise NotFound if document.nil?

      delete_result = document.destroy
      raise OperationFailure if delete_result == false

      document.build_data
    end
    module_function :delete

    # @return [GroundUser::Data] if the update succeeded
    # @raise NotFound if there is not user
    def last
      document = Document.last
      raise NotFound if document.nil?

      document.build_data
    end
    module_function :last

    def count_all
      Document.count
    end
    module_function :count_all

    def delete_all
      Document.destroy_all
    end
    module_function :delete_all

    def get_document(email)
      Document.where(email: email).first
    end
    module_function :get_document

    class Document
      include Mongoid::Document
      include Mongoid::Timestamps
      store_in collection: 'ground_users'

      field :email, type: String
      field :hashed_password, type: String
      field :salt, type: String

      def build_data
        GroundUser::Data.new(
          id.to_s,
          email,
          hashed_password,
          salt
        )
      end
    end
  end
end
