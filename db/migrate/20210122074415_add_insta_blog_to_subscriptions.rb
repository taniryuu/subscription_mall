class AddInstaBlogToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :insta_blog, :string
  end
end
