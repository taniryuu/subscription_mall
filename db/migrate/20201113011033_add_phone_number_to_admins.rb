class AddPhoneNumberToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :phone_number, :string
  end
end
