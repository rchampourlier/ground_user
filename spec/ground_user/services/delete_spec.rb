require 'spec_helper'
require 'services/delete'

describe 'GroundUser.delete(email)' do
  subject { GroundUser.delete(email) }
  let(:email) { 'valid@email.com' }
  let(:password) { SecureRandom.base64 }

  context 'matching user exists' do
    before { GroundUser.create(email, password) }
    include_examples 'ServiceResponse', :success, { GroundUser::Data => { email: 'valid@email.com' }}, []

    context 'delete failure' do

      before do
        allow(GroundUser::Persistence).to receive(:delete) { false }
      end

      include_examples 'ServiceResponse', :failure, { GroundUser::Data => { email: 'valid@email.com' }}, [:delete_failure]
    end
  end

  context 'no matching user' do
    include_examples 'ServiceResponse', :failure, nil, [:not_found]
  end
end
