class AddAddressToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :address, :string
  end
end
