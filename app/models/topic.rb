require "csv"

class Topic < ApplicationRecord
  belongs_to :category
  has_many :favorites, as: :favoritable

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "description", "symptoms", "title", "treatment" ]
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      rec = row.to_hash
      category_title = rec["category"]&.strip
      category = Category.find_by(category: category_title)
      Topic.create!(
        title: rec["title"],
        description: rec["description"],
        symptoms: rec["symptoms"],
        treatment: rec["treatment"],
        category: category
      )
    end
  end
end
