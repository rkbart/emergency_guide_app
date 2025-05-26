class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :emergency_contacts, dependent: :destroy
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: :topic
  has_many :checklists, dependent: :destroy

  after_create :assign_default_emergency_contacts
  after_create :assign_default_checklist_items

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

  def assign_default_checklist_items
     puts "📌 CHECKLIST SEED RUNNING for #{email}"
    default_checklists = [
      { items: "First Aid Kit", description: "Basic bandages, antiseptic wipes, tweezers, gloves, and tape.", checked: false },
      { items: "Emergency Contact Card", description: "List of important phone numbers and medical information.", checked: false },
      { items: "Pain Relievers", description: "Paracetamol or ibuprofen for minor aches and fever.", checked: false },
      { items: "Emergency Blanket", description: "Thermal blanket to prevent hypothermia.", checked: false },
      { items: "Whistle or Signaling Device", description: "For attracting help when injured or stranded.", checked: false },
      { items: "Medical Gloves", description: "For protection while giving first aid.", checked: false },
      { items: "Flashlight", description: "With extra batteries to see in low light situations.", checked: false },
      { items: "Alcohol or Disinfectant", description: "For wound cleaning and hand sanitation.", checked: false },
      { items: "Gauze Pads and Tape", description: "For dressing larger wounds.", checked: false },
      { items: "Thermometer", description: "For checking fever or illness.", checked: false },
      { items: "Emergency Drinking Water", description: "At least one liter per person per day.", checked: false },
      { items: "Non-perishable Food", description: "Canned or sealed food that won’t spoil.", checked: false },
      { items: "Dust Mask", description: "To help filter contaminated air.", checked: false },
      { items: "Personal Hygiene Items", description: "Tissues, hand sanitizer, feminine products.", checked: false },
      { items: "Battery-powered Radio", description: "To receive emergency broadcasts and updates.", checked: false }
    ]

    checklists.create!(default_checklists)
  end
end
