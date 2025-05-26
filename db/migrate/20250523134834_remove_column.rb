class RemoveColumn < ActiveRecord::Migration[8.0]
  def change
    remove_column :topics, :category, :string
  end
end
