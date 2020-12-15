class AddSearchToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :search, :string
  end
end
