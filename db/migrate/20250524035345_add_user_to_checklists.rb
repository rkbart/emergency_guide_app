class AddUserToChecklists < ActiveRecord::Migration[8.0]
  def change
    add_reference :checklists, :user, foreign_key: true
  end
end
