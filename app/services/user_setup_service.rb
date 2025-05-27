class UserSetupService
  def initialize(user)
    @user = user
  end

  def perform
    copy_default_contacts
    copy_default_checklists
  end

  private

  def copy_default_contacts
    EmergencyContact.system_defaults.each do |contact|
      @user.emergency_contacts.create!(
        contact.attributes.except("id", "created_at", "updated_at", "is_default")
      )
    end
  end

  def copy_default_checklists
    Checklist.system_defaults.each do |item|
      @user.checklists.create!(
        item.attributes.except("id", "created_at", "updated_at", "is_default")
      )
    end
  end
end