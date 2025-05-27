require "csv"

class Topic < ApplicationRecord
  belongs_to :category
  has_many :favorites, as: :favoritable

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category_id }
  validates :category, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "description", "symptoms", "title", "treatment" ]
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      rec = row.to_hash
      category_title = rec["category"]&.strip
      category = Category.find_by(category: category_title)

      next unless category # skip if category not found

      topic = Topic.find_or_initialize_by(
        title: rec["title"],
        category_id: category.id
      )

      # Update other attributes if they exist in CSV
      topic.description = rec["description"] if rec["description"].present?
      topic.symptoms = rec["symptoms"] if rec["symptoms"].present?
      topic.treatment = rec["treatment"] if rec["treatment"].present?

      # Only save if new record or changes exist
      topic.save! if topic.new_record? || topic.changed?
    end
  end
end
