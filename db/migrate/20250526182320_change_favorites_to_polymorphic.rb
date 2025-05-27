class ChangeFavoritesToPolymorphic < ActiveRecord::Migration[8.0]
  def change
    remove_column :favorites, :topic_id, :bigint

    add_reference :favorites, :favoritable, polymorphic: true, null: false, index: true
  end
end
