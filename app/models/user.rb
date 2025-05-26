class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :emergency_contacts, dependent: :destroy

  after_create :assign_default_emergency_contacts

  private

  def assign_default_emergency_contacts
    default_contacts = [
      { agency_name: "Philippine National Police (PNP)", phone_number: "117", location: "Nationwide" },
      { agency_name: "Bureau of Fire Protection (BFP)", phone_number: "160", location: "Nationwide" },
      { agency_name: "Philippine Red Cross", phone_number: "143", location: "Nationwide" },
      { agency_name: "NDRRMC", phone_number: "(02) 8920-0231", location: "Nationwide" },
      { agency_name: "Philippine Coast Guard", phone_number: "(02) 527-8481", location: "Nationwide" },
      { agency_name: "Department of Health (DOH)", phone_number: "(02) 8651-7800", location: "Nationwide" },
      { agency_name: "Philippine Medical Association", phone_number: "(02) 441-1615", location: "Nationwide" },
      { agency_name: "Land Transportation Office (LTO)", phone_number: "(02) 892-3831", location: "Nationwide" },
      { agency_name: "Manila Emergency Hotline", phone_number: "911", location: "Manila" }
    ]

    emergency_contacts.create!(default_contacts)
  end

  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: :topic
end
