class UserEmail < ApplicationRecord
  belongs_to :user, optional: true
  has_many :user_projects, dependent: :destroy

  def projects_notified
    self.user_projects.participation.notified.order(priority: :asc).includes(:project)
  end

  def projects_not_notified
    self.user_projects.participation.not_notified.order(priority: :asc).includes(:project)
  end

  def projects_mute
    self.user_projects.participation.mute.includes(:project)
  end

  def projects_invitations
    self.user_projects.invitation.includes(:project)
  end

  def projects_admins
    self.user_projects.admin.includes(:project)
  end

  def projects
    self.user_projects.includes(:project)
  end

end
