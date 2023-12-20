class Booking < ApplicationRecord
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'
  belongs_to :spa
  has_one :host, through: :spa, source: :user, foreign_key: 'user_id'
end
