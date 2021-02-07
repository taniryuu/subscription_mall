class RenameOwnerStoreInfomationColumnToTicketLogs < ActiveRecord::Migration[5.1]
  def change
    rename_column :ticket_logs, :owner_store_infomation, :owner_store_information
  end
end
