class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :title
      t.text :detail
      t.string :image_subscription
      t.integer :price
      t.text :subscription_detail
      t.string :script
      t.string :image_subscription2
      t.string :image_subscription3
      t.string :image_subscription4
      t.string :image_subscription5
      t.string :sub_image
      t.string :sub_image2
      t.string :sub_image3
      t.string :sub_image4
      t.string :sub_image5
      t.string :sub_image6
      t.string :sub_image7
      t.string :sub_image8
      t.string :sub_image9
      t.string :sub_image10
      t.string :sub_image11
      t.string :sub_image12
      t.text :blog
      t.text :shop_introduction
      t.string :qr_image
      t.text :address
      t.float :latitude
      t.float :longitude

      t.references :owner, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
