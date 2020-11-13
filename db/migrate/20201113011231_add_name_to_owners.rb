class AddNameToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :name, :string
  end
end
