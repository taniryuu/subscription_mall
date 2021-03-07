class AddPrivateStoreRefToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :private_store, foreign_key: true
  end
end
