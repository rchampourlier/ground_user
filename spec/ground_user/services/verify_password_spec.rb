require 'spec_helper'
require 'services/verify_password'

describe 'GroundUser.verify_password(email, password)' do
  before(:all) { @password = SecureRandom.base64 }

  subject { GroundUser.verify_password(email, password) }
  let(:email) { 'valid@email.com' }
  let(:password) { @password }

  context 'user found' do
    before { GroundUser.create(email, @password) }

    context 'submitted password is correct' do
      include_examples 'ServiceResponse', :success, true, []
    end

    context 'submitted password is wrong' do
      let(:password) { 'wrong_password' }
      include_examples 'ServiceResponse', :success, false, []
    end
  end

  context 'user not found' do
    include_examples 'ServiceResponse', :failure, nil, [:not_found]
  end
end
