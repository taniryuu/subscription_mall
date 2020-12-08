class AddKanaToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :kana, :string
  end
end
