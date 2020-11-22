class CreateCupons < ActiveRecord::Migration[5.1]
  def change
    create_table :cupons do |t|
      t.string :product
      t.string :discount
      t.integer :status
      t.string :image
      t.string :writing
      t.integer :limit
      t.text :reason
      t.references :review, foreign_key: true
      t.references :owner, foreign_key: true
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
