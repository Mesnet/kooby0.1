class UserInfo < ApplicationRecord
  validates :first_name, presence: true
  validates :second_name, presence: true
  validates :pseudo, presence: true

  belongs_to :user
end
