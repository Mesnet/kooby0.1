class User < ApplicationRecord
  include ActiveModel::Dirty
  before_update :sync_mail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_emails
  has_one :user_info, dependent: :destroy
  has_many :posts

  def emails
    self.user_emails
  end

  def projects_notified
    self.emails.collect { |email| email.projects_notified }.flatten
  end

  def projects_not_notified
    self.emails.collect { |email| email.projects_not_notified }.flatten
  end

  def projects_mute
    self.emails.collect { |email| email.projects_mute }.flatten
  end

  def projects_admin
    self.emails.collect { |email| email.projects_admins }.flatten
  end

  def projects_invitations
    self.emails.collect { |email| email.projects_invitations }.flatten
  end

  def user_projects 
    self.emails.collect { |email| email.projects }.to_a
  end

  private

  def sync_mail
    # After user has confirmed his mail, we add that email into his user_email (status: confirmed) 
    if self.confirmed_at_changed?
      # Find the user_mail corresponding to the user.mail
      mail = UserEmail.where(email: self.email).first
      #Check if this user_mail exist
      unless mail.nil?
        # Check if the user_mail is not already confirmed
        if mail.user_id == nil
          mail.update(user_id: self.id, confirmed: true)
        else
          #Send error and delete the current_user & warm the user related to the user_mail
        end
      else
        UserEmail.create(user_id: self.id, email: self.email, confirmed: true)
      end

    end
  end

end
