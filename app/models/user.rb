class User < ApplicationRecord
  has_secure_password

  validates :name, :username, presence: true
  normalizes :email, ->(email) {email.strip.downcase}
end
