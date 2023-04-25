class Location < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: %i[user_id country_code], message: 'already exists in favorites' }
  validates :country_code, presence: true
end
