class AddAddressToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :address, :string
  end
end
