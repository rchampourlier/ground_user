require 'spec_helper'
require 'utils/hash_password'

describe GroundUser::Utils do
  describe '::hash_password(password, salt)' do

    subject { GroundUser::Utils.hash_password(password, salt) }
    let(:password) { 'password' }

    context 'without salt' do
      let(:salt) { nil }

      it 'should return an array with password and salt' do
        expect(subject).to be_a Array
        expect(subject.length).to eq(2)
      end

      it 'should generate a salt and encrypt with it' do
        encrypted_password, generated_salt = subject
        re_encrypted_password = GroundUser::Utils.hash_password(password, generated_salt).first
        expect(re_encrypted_password).to eq(encrypted_password)
      end
    end

    context 'with salt' do
      let(:salt) { SecureRandom.base64(8) }

      it 'should encrypt with the salt' do
        encrypted_password, _ = subject
        re_encrypted_password = GroundUser::Utils.hash_password(password, salt).first
        expect(re_encrypted_password).to eq(encrypted_password)
      end

      it 'should return the encrypted password and the salt' do
        _, returned_salt = subject
        expect(returned_salt).to eq(salt)
      end
    end
  end
end
