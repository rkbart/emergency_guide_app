require "csv"

class Topic < ApplicationRecord
  belongs_to :category

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # rec = row.to_hash
      # Topic.create!(
      #   title: rec["title"],
      #   description: rec["description"],
      #   symptoms: rec["symptoms"],
      #   treatment: rec["treatment"]
      # )
      # category = Category.find_or_create_by(title: row["category_title"])

      # topic = Topic.find_or_initialize_by(title: row["title"], category: category)
      # topic.description = row["description"]
      # topic.symptoms = row["symptoms"]
      # topic.treatment = row["treatment"]
      # topic.save!
      # require "csv"




      rec = row.to_hash
      category_title = rec["category"]&.strip
      category = Category.find_by(title: category_title)

      if category
        Topic.create!(
          title: rec["title"],
          description: rec["description"],
          symptoms: rec["symptoms"],
          treatment: rec["treatment"],
          category: category  # ✅ Assign the Category object
        )
      else
        Rails.logger.warn "Skipping topic because category not found: #{category_title}"
      end
    end
  end
end
