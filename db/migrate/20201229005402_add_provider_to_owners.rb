class AddProviderToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :provider, :string
  end
end
