class CreateEmergencyContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :emergency_contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :agency_name
      t.string :phone_number
      t.string :location

      t.timestamps
    end
  end
end
