class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :emergency_contacts, dependent: :destroy
  has_many :checklists, dependent: :destroy

  has_many :chats
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: :favoritable, source_type: "Topic"
  has_many :favorite_chats, through: :favorites, source: :favoritable, source_type: "Chat"

  after_create :set_default_data

  private

  def set_default_data
    UserSetupService.new(self).perform
  end
end
