class Category < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "category", "description", "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "topics" ]
  end

  has_many :topics
end
