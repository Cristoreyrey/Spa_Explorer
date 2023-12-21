class Spa < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :bookings, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
  against: %i[name address],
  using: {
    tsearch: { prefix: true }
  }

  pg_search_scope :search_owned,
  against: %i[name address],
  using: {
    tsearch: { prefix: true }
  }
end
