class AddUserIdToTicketLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :ticket_logs, :user_id, :integer
  end
end
