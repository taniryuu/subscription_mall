class CreatePrivateStoreUserPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :private_store_user_plans do |t|
      t.string :customer_id, null: false
      t.integer :private_store_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
