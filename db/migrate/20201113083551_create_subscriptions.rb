class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :title
      t.text :detail
      t.string :image_subscription
      t.integer :price
      t.text :subscription_detail
      t.integer :category_name
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
