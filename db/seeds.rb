
public_user = User.find_or_create_by!(email: "public@example.com") do |u|
  u.password = SecureRandom.hex(10) # random password, won't be used
  u.password_confirmation = u.password
  u.confirmed_at = Time.current if u.respond_to?(:confirmed_at)
end

# Seed default public emergency contacts (accessible to guests)
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

default_contacts.each do |attrs|
  EmergencyContact.find_or_create_by!(agency_name: attrs[:agency_name], user_id: public_user.id) do |contact|
    contact.phone_number = attrs[:phone_number]
    contact.location = attrs[:location]
    contact.default = true
  end
end

# Create a seed user with personal emergency contacts
user = User.find_or_create_by!(email: "seeduser@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.confirmed_at = Time.current if u.respond_to?(:confirmed_at)
end

# Seed personal emergency contacts for that user
user_contacts = [
  { agency_name: "User Specific Contact 1", phone_number: "123456789", location: "Local" },
  { agency_name: "User Specific Contact 2", phone_number: "987654321", location: "Local" }
]

user_contacts.each do |attrs|
  EmergencyContact.find_or_create_by!(agency_name: attrs[:agency_name], user_id: user.id) do |contact|
    contact.phone_number = attrs[:phone_number]
    contact.location = attrs[:location]
    contact.default = false
  end
end
