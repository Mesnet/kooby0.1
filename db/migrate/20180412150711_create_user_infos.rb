class CreateUserInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_infos do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :second_name
      t.string :pseudo
      t.string :phone

      t.timestamps
    end
  end
end
