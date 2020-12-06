class AddDeletedAtToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :deleted_at, :datetime
  end
end
