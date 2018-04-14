class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :cat, default: 1
      t.timestamps
    end
  end
end
