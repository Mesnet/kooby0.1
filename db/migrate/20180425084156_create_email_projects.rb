class CreateEmailProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :email_projects do |t|
      t.string :email
      t.integer :role, default: 2
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
