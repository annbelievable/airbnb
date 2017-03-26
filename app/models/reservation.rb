class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :listing_id, presence: true
  belongs_to :user
  belongs_to :listing
end
