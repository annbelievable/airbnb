class Listing < ApplicationRecord
  belongs_to :user
  has_many  :reservations
  acts_as_taggable_on :tags
  mount_uploaders :photos, PhotoUploader
  # attr_accessor :photos
  # serialize :photos, JSON

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :user_id, presence: true

  #pagination
  paginates_per 20
end
