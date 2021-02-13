class ChangeDataUserIdToTicketLogs < ActiveRecord::Migration[5.1]
  def change
    change_column :ticket_logs, :user_id, :bigint
  end
end
