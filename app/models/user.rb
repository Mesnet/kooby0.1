class User < ApplicationRecord
  include ActiveModel::Dirty
  before_update :sync_mail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_emails

  def emails 
    self.user_emails
  end 

  private

  def sync_mail
    if self.confirmed_at_changed?
      UserEmail.create(user_id: self.id, email: self.email, confirmed: true)
    end
  end

end
