class AddRecommendToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :recommend, :boolean, default: true
  end
end
