class AddBlogToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :blog, :text
    add_column :subscriptions, :shop_introduction, :text
  end
end
