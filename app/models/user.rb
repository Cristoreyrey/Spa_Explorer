class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # OWNER:
  has_many :host_spas, foreign_key: :user_id, class_name: 'Spa'
  has_many :host_bookings, through: :host_spas, source: :bookings
  # GUEST:
  has_many :guest_bookings, foreign_key: :user_id, class_name: 'Booking'
  has_many :guest_spas, through: :guest_bookings, source: :spa
  ROLES = %w[guest host].freeze
  has_one_attached :profile_photo
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :role, presence: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :guest
  end

  def host?
    role == 'host'
  end

  def guest?
    role == 'guest'
  end

  def name
    "#{first_name} #{last_name}"
  end
end
