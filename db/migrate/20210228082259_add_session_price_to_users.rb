class AddSessionPriceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :session_price, :string
  end
end
