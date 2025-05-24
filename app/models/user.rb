class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :emergency_contacts, dependent: :destroy
  has_many :checklists, dependent: :destroy

  after_create :set_default_data

  private

  def set_default_data
    UserSetupService.new(self).perform
  end
end
