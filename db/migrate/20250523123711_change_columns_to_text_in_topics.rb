class ChangeColumnsToTextInTopics < ActiveRecord::Migration[7.0]
  def change
    change_column :topics, :description, :text
    change_column :topics, :symptoms, :text
    change_column :topics, :treatment, :text
  end
end
