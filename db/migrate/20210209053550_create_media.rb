class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :media_name
      t.string :media_image

      t.timestamps
    end
  end
end
