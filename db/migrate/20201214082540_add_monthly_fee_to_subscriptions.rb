class AddMonthlyFeeToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :monthly_fee, :integer
  end
end
