class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.string :owner_name
      t.string :shop_name
      t.string :content
      t.string :image_interview
      t.string :youtube_url
      t.string :music
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
