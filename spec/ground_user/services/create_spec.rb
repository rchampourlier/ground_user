require 'spec_helper'
require 'services/create'

describe GroundUser do
  describe '::create(email, password)' do

    subject { described_class.create(email, password) }
    let(:email) { 'valid@email.com' }
    let(:password) { SecureRandom.base64 }

    context 'valid parameters' do

      it 'should create an user' do
        expect { subject }.to change { GroundUser::Persistence.count_all }.by 1
      end

      include_examples 'ServiceResponse', :success, { GroundUser::Data => { email: 'valid@email.com' }}, []

      describe 'created user' do
        let(:created_user_document) { subject; GroundUser::Persistence::Document.last }

        before do
          allow(GroundUser::Utils).to receive(:hash_password) do |password|
            "encrypted#{password}"
          end
        end

        it 'should have the correct email' do
          expect(created_user_document.email).to eq(email)
        end

        it 'should have the correct hashed password' do
          expect(created_user_document.hashed_password).to eq("encrypted#{password}")
        end
      end
    end

    context 'already used email' do
      before { described_class.create(email, password) }

      it 'should not create an user' do
        expect { subject }.not_to change { GroundUser::Persistence.count_all }
      end

      include_examples 'ServiceResponse', :failure, nil, [:existing_user_with_email]

      it 'should return [:existing_user_with_email]' do
        expect(subject[:errors]).to eq [:existing_user_with_email]
      end
    end

    [
      {
        email: 'not@email',
        password: 'password',
        expected_errors: [:invalid_email]
      },
      {
        email: 'valid@email.com',
        password: 'pass',
        expected_errors: [:password_too_short]
      },
      {
        email: 'invalid@email',
        password: 'pass',
        expected_errors: [:invalid_email, :password_too_short]
      }
    ].each do |test_case|

      context "email=#{test_case[:email]}, password=#{test_case[:password]}" do

        let(:email) { test_case[:email] }
        let(:password) { test_case[:password] }

        it 'should not create an user' do
          expect { subject }.not_to change { GroundUser::Persistence.count_all }
        end

        it 'should return the expected errors' do
          expect(subject[:errors]).to eq test_case[:expected_errors]
        end
      end
    end
  end
end
