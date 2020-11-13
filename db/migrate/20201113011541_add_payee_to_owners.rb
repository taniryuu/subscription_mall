class AddPayeeToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :payee, :string
  end
end
