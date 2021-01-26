class CreateInstablogs < ActiveRecord::Migration[5.1]
  def change
    create_table :instablogs do |t|
      t.string :content
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
