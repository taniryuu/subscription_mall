class Blog < ApplicationRecord
  # belongs_to :admin
  mount_uploader :image_photo, BlogUploader
end
