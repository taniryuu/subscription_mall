class AddKanaToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :kana, :string
  end
end
