require 'spec_helper'
require 'services/exist'

describe 'GroundUser.exist(email)' do
  subject { GroundUser.exist(email) }
  let(:email) { 'valid@email.com' }
  let(:password) { SecureRandom.base64 }

  context 'matching user exists' do
    before { GroundUser.create(email, password) }

    include_examples 'ServiceResponse', :success, true, []
  end

  context 'no matching user' do
    include_examples 'ServiceResponse', :success, false, []
  end

  context 'operation failure' do
    before do
      allow(GroundUser::Persistence).to receive(:exist) do
        raise GroundUser::Persistence::OperationFailure
      end
    end

    include_examples 'ServiceResponse', :failure, nil, [:operation_failure]
  end
end
