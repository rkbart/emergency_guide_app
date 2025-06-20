class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
