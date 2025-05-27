class Checklist < ApplicationRecord
  belongs_to :user, optional: true

  validates :items, presence: true

  scope :system_defaults, -> { where(is_default: true, user_id: nil) }
  scope :user_items, ->(user) { where(user: user) }

  scope :for_display, ->(user) {
    user.present? ? user_items(user) : system_defaults
  }
end
