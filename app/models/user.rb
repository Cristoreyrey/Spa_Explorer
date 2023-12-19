class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :spas
  has_many :bookings # as a guest
  has_many :spas, through: :bookings # as an owner
  has_one_attached :profile_photo

  ROLES = %w[guest host].freeze
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :role, presence: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :guest
  end
end
