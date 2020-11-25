class Cupon < ApplicationRecord
  # belongs_to :review
  # belongs_to :owner
  # belongs_to :user
  # belongs_to :admin
  enum status: { open: 0, closed: 1 }
  mount_uploader :image, ImageUploader
end
