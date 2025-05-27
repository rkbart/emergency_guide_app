class Chat < ApplicationRecord
  belongs_to :user
  has_many :favorites, as: :favoritable

  validates :question, :answer, presence: true
end
