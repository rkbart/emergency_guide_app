class AddDefaultFieldsToChecklists < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :is_default, :boolean, default: false
    change_column_null :checklists, :user_id, true
  end
end
