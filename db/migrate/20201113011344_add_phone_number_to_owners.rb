class AddPhoneNumberToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :phone_number, :string
  end
end
