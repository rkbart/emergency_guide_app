require "csv"

class Topic < ApplicationRecord
  belongs_to :category
  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user

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
