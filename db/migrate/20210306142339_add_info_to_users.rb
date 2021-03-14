class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :info, :string
  end
end
