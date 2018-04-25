class UserProject < ApplicationRecord
  belongs_to :project
  belongs_to :user_email

  scope :participation, -> { where(participate: true) }
  scope :invitation, -> { where(participate: false) }

  scope :notified, -> { where.not(notif: 0, priority: 3 ) }
  scope :not_notified, -> { where(notif: 0 ).where.not(priority: 3) }
  scope :mute, -> { where(priority: 3 ) }

  scope :admin, -> { where(role: 1) }
  scope :editor, -> { where(role: 2) }
  scope :viewer, -> { where(role: 3) }

  def email 
    self.user_email
  end

  def user
    self.email.user
  end

end