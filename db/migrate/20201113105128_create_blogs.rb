class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :image_photo
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
