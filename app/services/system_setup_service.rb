class SystemSetupService
  def self.load_emergency_contacts
    YAML.load_file(Rails.root.join("config", "default_data", "emergency_contacts.yml"))
  end

  def self.load_checklist_items
    YAML.load_file(Rails.root.join("config", "default_data", "checklist_items.yml"))
  end

  def self.create_defaults
    create_system_contacts
    create_system_checklists
  end

  private

  def self.create_system_contacts
    load_emergency_contacts.each do |contact|
      EmergencyContact.find_or_create_by!(
        agency_name: contact["agency_name"],
        phone_number: contact["phone_number"],
        is_default: true,
        user_id: nil
      ) do |c|
        c.location = contact["location"]
        c.agency_name = contact["agency_name"]
      end
    end
  end

  def self.create_system_checklists
    load_checklist_items.each do |item|
      next if item["items"].blank?

      Checklist.find_or_create_by!(
        items: item["items"].to_s.strip,
        is_default: true,
        user_id: nil
      ) do |c|
        c.description = item["description"].to_s.strip
        c.checked = false
      end
    end
  end
end
