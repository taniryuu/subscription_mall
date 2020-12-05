class AddMessageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :message, :text
    add_column :users, :subject, :string
  end
end
