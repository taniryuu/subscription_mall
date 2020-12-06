class AddImageSubscription4ToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :image_subscription4, :string
  end
end
