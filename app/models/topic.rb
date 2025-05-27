class Topic < ApplicationRecord
  belongs_to :category
  has_many :favorites, as: :favoritable

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "description", "symptoms", "title", "treatment" ]
  end
end
