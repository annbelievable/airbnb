class User < ApplicationRecord
  include Clearance::User

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #the 2 ways to bypass clearance doesnt work:
  #if: User.new.authentications.empty?
  #on: :create_user
  validates :username, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  #to confirm the user password when sign in
  # validates_confirmation_of :password
  include Clearance::User

  #for oauth
  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.create!(username: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"], password: SecureRandom.base64(5))
    user.authentications << (authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
end
