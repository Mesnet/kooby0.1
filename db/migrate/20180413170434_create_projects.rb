class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :cat, default: 1
      t.text :description
      t.boolean :removed, default: false
      t.timestamps
    end
  end
end