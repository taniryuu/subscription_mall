class AddDetailInfoToTicketLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :ticket_logs, :owner_name, :string
    add_column :ticket_logs, :owner_email, :string
    add_column :ticket_logs, :owner_phone_number, :string
    add_column :ticket_logs, :owner_store_infomation, :string    
    add_column :ticket_logs, :subscription_name, :string    
    add_column :ticket_logs, :private_store_name, :string
    add_column :ticket_logs, :subscription_fee, :string    
    add_column :ticket_logs, :issue_ticket_day, :date    
  end
end
