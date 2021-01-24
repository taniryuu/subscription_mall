class AddInstaContentToInstablogs < ActiveRecord::Migration[5.1]
  def change
    add_column :instablogs, :insta_content, :text
  end
end
