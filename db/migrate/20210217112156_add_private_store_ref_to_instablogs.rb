class AddPrivateStoreRefToInstablogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :instablogs, :private_store, foreign_key: true
  end
end
