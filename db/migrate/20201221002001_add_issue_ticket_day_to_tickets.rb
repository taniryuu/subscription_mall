class AddIssueTicketDayToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :issue_ticket_day, :date
  end
end
