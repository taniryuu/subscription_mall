class AddLineIdToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :line_id, :string
  end
end
