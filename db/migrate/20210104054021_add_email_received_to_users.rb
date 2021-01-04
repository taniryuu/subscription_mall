class AddEmailReceivedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_received, :boolean, default: true, null: false
  end
end
