class Image < ApplicationRecord
  # belongs_to :user
  # belongs_to :owner
  mount_uploader :subscription_image, ImageUploader
  # has_many :subscription_images
  # has_many :subscriptions, through: :category_subscriptions
  belongs_to :subscription, optional: true
  # belongs_to :interview
  # belongs_to :blog
end
