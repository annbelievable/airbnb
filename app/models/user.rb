class User < ApplicationRecord
  include Clearance::User
  mount_uploader :photo, PhotoUploader
  has_many :listings
  has_many :reservations
  has_many :authentications, :dependent => :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #the 2 ways to bypass clearance doesnt work:
  #if: User.new.authentications.empty?
  #on: :create_user
  validates :username, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  # validates :password, length: { minimum: 6 }
  # validates :role, inclusion: { in: ["superadmin", "moderator", "customer"] }
  # validates :phone_number, length: { minimum: 6, maximum: 20 }
  enum role: [:superadmin, :moderator, :customer]

  #to confirm the user password when sign in
  # validates_confirmation_of :password

  #for oauth
  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.create!(username: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"], password: SecureRandom.base64(5))
    user.authentications << (authentication)
    return user
  end
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  #pagination
  paginates_per 10
end
