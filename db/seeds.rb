require 'csv'
# require 'system_setup_service'

EmergencyContact.destroy_all
puts "Clearing contacts"

Checklist.destroy_all
puts "Clearing checklists"

puts "Creating system default content..."
SystemSetupService.create_defaults
puts "Created #{EmergencyContact.system_defaults.count} default contacts"
puts "Created #{Checklist.system_defaults.count} default checklist items"

Topic.destroy_all
puts "Clearing first aid topics"
Category.destroy_all
puts "Clearing first aid categories"

categories_csv = File.read(Rails.root.join('db', 'seeds', 'first_aid_categories.csv'))
categories_csv = CSV.parse(categories_csv, headers: true, encoding: 'UTF-8')

categories_csv.each do |row|
  Category.create!(
    category: row['category'],
    title: row['title'],
    description: row['description']
  )
end

puts "Created #{Category.count} categories"

topics_csv = File.read(Rails.root.join('db', 'seeds', 'first_aid_topics.csv'))
topics_csv = CSV.parse(topics_csv, headers: true, encoding: 'UTF-8')

topics_csv.each do |row|
  category = Category.find_by(category: row['category'])

  if category
    Topic.create!(
      title: row['title'],
      description: row['description'],
      symptoms: row['symptoms'],
      treatment: row['treatment'],
      category_id: category.id
    )
  else
    puts "Could not find category '#{row['category']}' for topic '#{row['title']}'"
  end
end

puts "Created #{Topic.count} topics"

# User.create!(email: "avionschoolproject@gmail.com", password: "password", confirmed_at: Time.now)
# puts "Created avionschoolproject@gmail.com user"
