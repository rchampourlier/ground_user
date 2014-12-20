require 'spec_helper'
require 'services/change_password'
require 'services/verify_password'

describe 'GroundUser.change_password(email, password)' do

  subject { GroundUser.change_password(email, password) }
  let(:email) { 'valid@email.com' }
  let(:password) { SecureRandom.base64 }

  context 'user found' do
    before { GroundUser.create(email, SecureRandom.base64) }

    context 'new password is correct' do

      context 'save successful' do
        include_examples 'ServiceResponse', :success, { GroundUser::Data => { email: 'valid@email.com' }}, []

        it 'should correctly change the password' do
          subject
          expect(GroundUser.verify_password(email, password).data).to eq(true)
        end
      end

      context 'failed save' do
        before do
          allow(GroundUser::Persistence).to receive(:update) do |email, attributes|
            raise GroundUser::Persistence::OperationFailure
          end
        end

        include_examples 'ServiceResponse', :failure, nil, [:save_failure]
      end
    end

    context 'new password is too short' do
      let(:password) { 'pass' }
      include_examples 'ServiceResponse', :failure, nil, [:password_too_short]
    end
  end

  context 'user not found' do
    include_examples 'ServiceResponse', :failure, nil, [:not_found]
  end
end
