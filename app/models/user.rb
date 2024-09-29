class User < ApplicationRecord
  has_secure_password

  # Optional validations
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
