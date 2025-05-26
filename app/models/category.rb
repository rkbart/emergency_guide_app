require "csv"
class Category < ApplicationRecord
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    Category.create! row.to_hash
    end
  end

  has_many :topics
end
