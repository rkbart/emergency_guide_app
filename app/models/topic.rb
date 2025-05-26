class Topic < ApplicationRecord
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "description", "symptoms", "title", "treatment" ]
  end
end
