class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :surname
      t.string :pseudo
      t.string :email
      t.string :phone
      t.references :user, foreign_key: true
      t.references :user_email, foreign_key: true

      t.timestamps
    end
  end
end
