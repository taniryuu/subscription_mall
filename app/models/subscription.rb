class Subscription < ApplicationRecord
  belongs_to :owner
  belongs_to :shop
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  enum price: { "3,000"=> 0, "12,000"=> 1, "18,000"=> 2, "25,000"=> 3, "50,000"=> 4, "100,000"=> 5}
  # attachment :image_subscription

  mount_uploader :image_subscription, ImageUploader
  mount_uploader :image_subscription2, ImageUploader
  mount_uploader :image_subscription3, ImageUploader
  mount_uploader :image_subscription4, ImageUploader
end
