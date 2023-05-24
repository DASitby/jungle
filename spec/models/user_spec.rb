require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'different_password')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires password and password_confirmation when creating the model' do
      user = User.new(email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'validates uniqueness of email (case-insensitive)' do
      User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')

      user = User.new(email: 'TEST@example.com', password: 'another_password', password_confirmation: 'another_password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
