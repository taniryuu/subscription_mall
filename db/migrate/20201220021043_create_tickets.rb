class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :owner_name
      t.string :owner_email
      t.string :owner_phone_number
      t.string :owner_store_information
      t.string :owner_payee
      t.string :subscription_name
      t.string :private_store_name
      t.string :subscription_fee
      t.date :use_ticket_day
      t.date :issue_ticket_day

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
