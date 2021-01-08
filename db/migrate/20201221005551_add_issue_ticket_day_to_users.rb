class AddIssueTicketDayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :issue_ticket_day, :date
  end
end
