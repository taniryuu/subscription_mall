class AddShopIdToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :shop_id, :integer, foreign_key: true
  end
end
