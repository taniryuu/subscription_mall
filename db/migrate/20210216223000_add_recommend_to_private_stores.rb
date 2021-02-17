class AddRecommendToPrivateStores < ActiveRecord::Migration[5.1]
  def change
    add_column :private_stores, :recommend, :boolean, default: true
  end
end
