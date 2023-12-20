class Spa < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :bookings, dependent: :destroy
end
