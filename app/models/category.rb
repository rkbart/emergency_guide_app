require "csv"

class Category < ApplicationRecord
  has_many :topics

  validates :category, presence: true, uniqueness: true
  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "category", "description", "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "topics" ]
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      record = row.to_hash
      # Find or initialize by a unique attribute (using 'category' field as the unique identifier)
      category = find_or_initialize_by(category: record["category"])

      # Update other attributes
      category.title = record["title"] if record["title"].present?
      category.description = record["description"] if record["description"].present?

      category.save! if category.new_record? || category.changed?
    end
  end
end
