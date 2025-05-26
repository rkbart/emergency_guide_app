class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :category
      t.string :title
      t.string :description
    end
  end
end
