class CreateCategorySubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :category_subscriptions do |t|
      t.references :category, foreign_key: true
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
