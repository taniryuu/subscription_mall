class AddInstaContentToPrivateStoreInstablogs < ActiveRecord::Migration[5.1]
  def change
    add_column :private_store_instablogs, :insta_content, :text
  end
end
