class RemoveInvoiceFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :invoice, :string
  end
end
