class DefaultDataService
  def self.load_emergency_contacts
    YAML.load_file(Rails.root.join("config", "default_data", "emergency_contacts.yml"))
  end

  def self.load_checklist_items
    YAML.load_file(Rails.root.join("config", "default_data", "checklist_items.yml"))
  end
end
