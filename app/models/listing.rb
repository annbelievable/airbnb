class Listing < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
  belongs_to :user

  #pagination
  paginates_per 20
end
