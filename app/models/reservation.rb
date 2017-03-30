class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :listing_id, presence: true
  belongs_to :user
  belongs_to :listing
  validate :check_availability

  def overlaps?(range1, range2)
    (range1.start_date - range2.end_date) * (range2.start_date - range1.end_date) >= 0
  end

  def check_availability
    listing = Listing.find(self.listing_id)
    listing.reservations.each do |r|
      if self.overlaps?(r, self)
        return self.errors.add(:messages, "Failed!")
      end
    end
  end

end
