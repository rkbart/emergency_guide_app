class CreateChecklists < ActiveRecord::Migration[8.0]
  def change
    create_table :checklists do |t|
      t.string :items
      t.string :description
      t.boolean :checked
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
