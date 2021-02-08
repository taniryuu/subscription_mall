class CreateUserPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :user_plans do |t|
      t.integer :price, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
