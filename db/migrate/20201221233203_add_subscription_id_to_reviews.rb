class AddSubscriptionIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :subscription, foreign_key: true
  end
end
