class AddMessageToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :message, :text
    add_column :owners, :subject, :string
  end
end
