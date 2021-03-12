class CreatePrivateStoreInstablogs < ActiveRecord::Migration[5.1]
  def change
    create_table :private_store_instablogs do |t|
      t.string :content
      t.references :private_store, foreign_key: true

      t.timestamps
    end
  end
end
