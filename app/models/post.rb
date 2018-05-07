class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  has_many :elements, dependent: :destroy
  accepts_nested_attributes_for :elements, :reject_if => lambda { |a| a[:cat].blank? }


  scope :active, -> { where(removed: false) }
  scope :published, -> { where(publish: true) }
  scope :unpublished, -> { where(publish: false) }

  def cached_user
    self.user
  end

end
