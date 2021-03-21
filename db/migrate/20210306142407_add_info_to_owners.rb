class AddInfoToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :info, :string
  end
end
