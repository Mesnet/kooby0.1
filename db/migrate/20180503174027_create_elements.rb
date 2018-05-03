class CreateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :elements do |t|
      t.references :post, foreign_key: true
      t.integer :cat

      t.timestamps
    end
  end
end
