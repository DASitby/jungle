class User < ApplicationRecord

  has_secure_password

  attribute :first_name, :string
  attribute :last_name, :string

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.where('LOWER(email) = ?', email.strip.downcase).first
    if user && user&.authenticate(password.to_s)
      user 
    else
      nil
    end
  end
end
