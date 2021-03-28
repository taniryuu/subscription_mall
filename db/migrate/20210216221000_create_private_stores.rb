class CreatePrivateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :private_stores do |t|
      t.integer :ordinal
      t.string :name
      t.string :title
      t.text :detail
      t.string :image_private_store
      t.integer :price
      t.text :private_store_detail
      #t.integer :category_name
      t.integer :shop_id, foreign_key: true
      t.string :script
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
      t.integer :category_id, index: true, foreign_key: true
      #t.integer :monthly_fee
      t.text :blog
      t.text :shop_introduction
      t.string :qr_image
      t.text :address
      t.float :latitude
      t.float :longitude
      t.string :product_id
      t.boolean :trial, default: false

      t.references :owner, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
