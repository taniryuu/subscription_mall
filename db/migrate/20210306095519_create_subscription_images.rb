class CreateSubscriptionImages < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_images do |t|
      t.integer :subscription_id, index: true, foreign_key: true
      t.integer :image_id, index: true

      t.timestamps
    end
  end
end
