class AddStoreInformationToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :store_information, :string
  end
end
