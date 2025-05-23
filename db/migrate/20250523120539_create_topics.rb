class CreateTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.string :description
      t.string :symptoms
      t.string :treatment
      t.string :category
      t.references :category, null: false, foreign_key: true
    end
  end
end
