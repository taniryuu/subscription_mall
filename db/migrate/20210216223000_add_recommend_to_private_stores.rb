class AddRecommendToPrivateStores < ActiveRecord::Migration[5.1]
  def change
    add_column :private_stores, :recommend, :boolean, default: true
    add_column :private_stores, :category_private_stores_id, :integer
  end
end
