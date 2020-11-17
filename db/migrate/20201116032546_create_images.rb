class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image_subscription_id
      t.string :image_interview_id
      t.text :comment
      t.datetime :time
      t.references :user, foreign_key: true
      t.references :owner, foreign_key: true
      t.references :subscription, foreign_key: true
      t.references :interview, foreign_key: true
      t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
