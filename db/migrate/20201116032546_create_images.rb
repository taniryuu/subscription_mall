class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :subscription_id,   null:false
      t.string :subscription_image,   null:false
      # t.string :image_interview_id
      t.text :comment
      t.datetime :time
      # t.references :user, foreign_key: true
      # t.references :owner, foreign_key: true
      # t.references :subscription,  null: false, foreign_key: true
      # t.references :interview, foreign_key: true
      # t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
