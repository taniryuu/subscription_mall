class AddEmailToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :email, :string
  end
end
