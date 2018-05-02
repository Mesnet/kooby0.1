class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  scope :active, -> { where(removed: false) }
  scope :published, -> { where(publish: true) }
  scope :unpublished, -> { where(publish: false) }
end
