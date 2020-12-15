class AddCategoryGenreToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :category_genre, :integer
  end
end
