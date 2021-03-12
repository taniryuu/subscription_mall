class AddInstaBlogToPrivateStores < ActiveRecord::Migration[5.1]
  def change
    add_column :private_stores, :insta_blog, :string
  end
end
