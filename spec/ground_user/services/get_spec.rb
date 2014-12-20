require 'spec_helper'
require 'services/get'

describe 'GroundUser.get(email)' do
  subject { GroundUser.get(email) }
  let(:email) { 'valid@email.com' }
  let(:password) { SecureRandom.base64 }

  context 'matching user exists' do
    before { GroundUser.create(email, password) }
    include_examples 'ServiceResponse', :success, { GroundUser::Data => { email: 'valid@email.com' }}, []
  end

  context 'no matching user' do
    include_examples 'ServiceResponse', :failure, nil, [:not_found]
  end
end
