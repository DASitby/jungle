require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'different_password')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires password and password_confirmation when creating the model' do
      user = User.new(first_name:"David", last_name: "Sooley", email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'validates uniqueness of email (case-insensitive)' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      user = User.new(first_name:"David", last_name: "Sooley", email: 'TEST@example.com', password: 'another_password', password_confirmation: 'another_password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'requires email, first name, and last name' do
      user = User.new(email: nil, name: nil, first_name: nil, last_name: nil, password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
      expect(user.errors[:first_name]).to include("can't be blank")
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'requires a minimum password length' do
      user = User.new(email: 'test@example.com', name: 'John Doe', first_name: 'John', last_name: 'Doe', password: 'pass', password_confirmation: 'pass')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns the user if authenticated successfully' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to be_a(User)
    end

    it 'returns nil if authentication fails (incorrect password)' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil if authentication fails (incorrect email)' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      authenticated_user = User.authenticate_with_credentials('wrong_email@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'ignores leading/trailing whitespace in the email' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to be_a(User)
    end

    it 'ignores case sensitivity in the email' do
      User.create(first_name:"David", last_name: "Sooley", email: 'test@example.com', password: 'password', password_confirmation: 'password')

      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to be_a(User)
    end
  end
end
