class AddEmailReceivedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notification_received, :boolean, default: true, null: false
  end
end
