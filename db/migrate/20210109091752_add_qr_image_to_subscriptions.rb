class AddQrImageToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :qr_image, :string
  end
end
