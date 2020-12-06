class AddImageSubscription3ToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :image_subscription3, :string
  end
end
