class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :content
      t.integer :price
      t.text :subscription_detail
      t.references :subscription, foreign_key: true
      t.references :owner, foreign_key: true
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
