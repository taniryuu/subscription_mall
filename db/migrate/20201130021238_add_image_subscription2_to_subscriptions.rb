class AddImageSubscription2ToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :image_subscription2, :string
  end
end
