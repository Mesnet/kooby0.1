class CreateUserEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_emails do |t|
      t.string :email, nill: false
      t.string :password
      # If the mail is linked to a User account
      t.boolean :linked, default: false
      # If the access to the native mailbox (like gmail) is confirmed
      t.boolean :confirmed, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
