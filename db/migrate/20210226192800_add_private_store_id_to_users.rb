class AddPrivateStoreIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :private_store_id, :integer
  end
end

