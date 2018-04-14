class UserProject < ApplicationRecord
  belongs_to :project
  belongs_to :user_email

  scope :participation, -> { where(participate: true) }
  scope :invitation, -> { where(participate: false) }
end
