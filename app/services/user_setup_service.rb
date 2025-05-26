class UserSetupService
  def initialize(user)
    @user = user
  end

  def perform
    create_emergency_contacts
    create_checklist_items
  end

  private

  def create_emergency_contacts
    contacts = DefaultDataService.load_emergency_contacts
    contacts.each do |contact|
      @user.emergency_contacts.create!(contact)
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create emergency contacts: #{e.message}"
  end

  def create_checklist_items
    DefaultDataService.load_checklist_items.each do |item|
      next if item["items"].blank? # Skip blank items

      @user.checklists.create!(
        items: item["items"].to_s.strip, # Convert to string and remove whitespace
        description: item["description"].to_s.strip,
        checked: false
      )
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to create item '#{item['items']}': #{e.message}"
    end
  end
end
