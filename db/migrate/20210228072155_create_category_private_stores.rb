class CreateCategoryPrivateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :category_private_stores do |t|
      t.integer :category_id, index: true, foreign_key: true
      t.integer :private_store_id, index: true
      t.integer :owner_id

      t.timestamps
    end
  end
end
