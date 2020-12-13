class AddGenreToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :genre, :string
    add_column :categories, :image_category, :string
  end
end
