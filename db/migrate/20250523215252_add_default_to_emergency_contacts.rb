class AddDefaultToEmergencyContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :emergency_contacts, :default, :boolean, default: false, null: false
  end
end
