class AddUseTicketDayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :use_ticket_day, :date
  end
end
