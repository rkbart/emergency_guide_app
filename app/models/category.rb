require "csv"

class Category < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "category", "description", "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "topics" ]
  end

  has_many :topics

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    rec = row.to_hash
    Category.create!(
      category: rec["category"],
      title: rec["title"],
      description: rec["description"]
    )
    end
  end
end
