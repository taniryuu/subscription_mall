class AddLineIdToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :line_id, :string
  end
end
