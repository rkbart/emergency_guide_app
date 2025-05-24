class EmergencyContact < ApplicationRecord
  belongs_to :user, optional: true

  validates :agency_name, presence: true
  validates :phone_number, presence: true
  validates :location, presence: true
end
