class User < ApplicationRecord
  include Clearance::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  #to confirm the user password when sign in
  validates_confirmation_of :password
  include Clearance::User
end
