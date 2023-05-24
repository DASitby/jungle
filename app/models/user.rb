class User < ApplicationRecord

  has_secure_password

  attribute :first_name, :string
  attribute :last_name, :string

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
end
