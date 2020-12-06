class AddRateToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :rate, :float
    add_column :reviews, :image_id, :string
  end
end
