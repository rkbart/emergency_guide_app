class Chat < ApplicationRecord
  belongs_to :user
  has_many :favorites, as: :favoritable

  validates :question, presence: true
end
