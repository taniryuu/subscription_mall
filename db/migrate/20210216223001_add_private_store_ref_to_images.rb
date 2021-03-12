class AddPrivateStoreRefToImages < ActiveRecord::Migration[5.1]
  def change
    add_reference :images, :private_store, foreign_key: true
  end
end
