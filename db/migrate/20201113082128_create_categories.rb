class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      # t.integer :subscription_id
      t.string :image_category
      t.string :search

      t.timestamps
    end
  end
end
