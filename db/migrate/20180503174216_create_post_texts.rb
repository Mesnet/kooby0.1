class CreatePostTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :post_texts do |t|
      t.references :element, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
