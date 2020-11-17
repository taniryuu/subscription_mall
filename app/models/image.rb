class Image < ApplicationRecord
  # belongs_to :user
  # belongs_to :owner
  mount_uploader :image_subscription_id, ImageUploader
  belongs_to :subscription
  # belongs_to :interview
  # belongs_to :blog
end
