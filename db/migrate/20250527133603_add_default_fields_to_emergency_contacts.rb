class AddDefaultFieldsToEmergencyContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :emergency_contacts, :is_default, :boolean, default: false
    change_column_null :emergency_contacts, :user_id, true
  end
end
