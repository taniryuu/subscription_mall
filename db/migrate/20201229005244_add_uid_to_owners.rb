class AddUidToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :uid, :string
  end
end
