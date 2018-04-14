class UserEmail < ApplicationRecord
  belongs_to :user, optional: true
  has_many :user_projects, dependent: :destroy

  def projects 
    self.user_projects.participation.includes(:project).map(&:project)
  end

  def projects_invitations
    self.user_projects.invitation.includes(:project).map(&:project)
  end

end
