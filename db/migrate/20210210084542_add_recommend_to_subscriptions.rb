class AddRecommendToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :recommend, :boolean, default: true
    add_column :subscriptions, :favorite, :boolean, default: false
    # add_column :subscriptions, :category_id, :integer
    add_column :subscriptions, :category_subscriptions_id, :integer
  end
end
