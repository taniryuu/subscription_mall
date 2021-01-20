class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :content
      t.integer :score
      t.float :rate
      t.string :image_id
      t.string :email
      t.references :subscription, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
