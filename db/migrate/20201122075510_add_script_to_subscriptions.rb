class AddScriptToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :script, :string
  end
end
