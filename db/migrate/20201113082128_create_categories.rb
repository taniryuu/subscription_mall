class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :owner, foreign_key: true
      t.string :genre
      t.string :image_category
      t.string :search

      t.timestamps
    end
  end
end
