class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :ordinal
      t.string :name
      t.string :title
      t.text :detail
      t.string :image_subscription
      t.integer :price
      t.text :subscription_detail
      t.string :email
      t.string :phone_number
      t.string :subject
      t.string :message
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
      t.string :admin_subscription_check
      t.string :situation
      t.string :admin_last_check
      t.string :trial_check
      t.string :trial_last_check
      t.integer :category_id, index: true, foreign_key: true
      t.text :blog
      t.text :shop_introduction
      t.text :site
      t.string :qr_image
      t.text :address
      t.float :latitude
      t.float :longitude
      t.boolean :trial
      t.boolean :takeout, default: false
      t.integer :preparation_time, default: 0

      t.references :owner, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
