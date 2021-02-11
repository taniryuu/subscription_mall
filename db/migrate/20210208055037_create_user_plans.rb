class CreateUserPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :user_plans do |t|
      t.string :customer_id, null: false
      t.integer :subscription_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
