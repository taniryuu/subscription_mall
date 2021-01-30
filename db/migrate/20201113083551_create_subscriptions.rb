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
      t.integer :shop_id, foreign_key: true
      t.string :script
      t.string :image_subscription2
      t.string :image_subscription3
      t.string :image_subscription4
      t.string :image_subscription5
      t.integer :category_genre
      t.integer :monthly_fee
      t.text :blog
      t.text :shop_introduction
      t.string :qr_image
      t.text :address
      t.float :latitude
      t.float :longitude

      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
