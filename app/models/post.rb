class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project
  scope :active, -> { where(removed: false) }
end
