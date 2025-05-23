class Checklist < ApplicationRecord
  # belongs_to :user

  validates :items, presence: true
end
