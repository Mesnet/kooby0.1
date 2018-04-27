class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :user_email
end
