class EmergencyContact < ApplicationRecord
  belongs_to :user, optional: true

  validates :agency_name, presence: true
  validates :phone_number, presence: true
  validates :location, presence: true

  scope :system_defaults, -> { where(is_default: true, user_id: nil) }
  scope :user_contacts, ->(user) { where(user: user) }

  scope :for_display, ->(user) {
    user.present? ? user_contacts(user) : system_defaults
  }
end
