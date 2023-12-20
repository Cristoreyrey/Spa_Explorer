class Spa < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :bookings, dependent: :destroy
end
