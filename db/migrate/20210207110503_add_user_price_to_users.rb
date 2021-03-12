class AddUserPriceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_price, :integer
    add_column :users, :session_price, :integer
  end
end
