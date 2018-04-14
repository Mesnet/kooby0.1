class CreateUserProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_projects do |t|
      t.references :project, foreign_key: true
      t.references :user_email, foreign_key: true
      t.integer :role, default: 2
      t.integer :notif, default: 0
      t.boolean :mute, default: false
      t.boolean :participate, default: false
      
      t.timestamps
    end
  end
end
