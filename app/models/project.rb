class Project < ApplicationRecord
  validates :name, presence: true

  has_many :user_projects

  default_scope {where(removed: false)} 

  def participants
    self.user_projects.participation.order("role ASC")
  end

  def inviteds
    self.user_projects.invitation.order("role ASC")
  end

  def admins
    self.user_projects.admin.participation.includes(:user_email).map(&:user_email)
  end

end


class Group < ApplicationRecord
  default_scope {order(priority: asc)} 

  scope :notified, -> { where.not(notifications: 0) }
  scope :not_notified, -> { where(notifications: 0) }
  
end