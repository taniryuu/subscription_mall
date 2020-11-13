class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :category_name
      t.string :monthly_fee
      t.string :phone_number
      t.string :store_information
      t.string :payee
      t.string :line_id
      t.string :address
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
