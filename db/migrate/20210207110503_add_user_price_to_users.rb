class AddUserPriceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_price, :integer
  end
end
