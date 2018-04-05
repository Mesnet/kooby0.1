class UserEmail < ApplicationRecord
  belongs_to :user, optional: true
end
