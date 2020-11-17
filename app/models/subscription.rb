class Subscription < ApplicationRecord
  belongs_to :owner
  belongs_to :shop, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  enum price: { "3,000"=> 0, "12,000"=> 1, "18,000"=> 2, "25,000"=> 3, "50,000"=> 4, "100,000"=> 5}
  # attachment :image_subscription
end
