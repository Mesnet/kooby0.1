class Element < ApplicationRecord
  belongs_to :post
  has_many :post_texts, dependent: :destroy
  accepts_nested_attributes_for :post_texts, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

end
