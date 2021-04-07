class AddUsedTrialToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :used_trial, :boolean, default: false, null: false
  end
end
