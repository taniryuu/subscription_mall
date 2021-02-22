class Medium < ApplicationRecord

  mount_uploader :media_image, MediaUploader
  validates :media_name, presence: true: { maximum: 100 }
  validates :media_image, presence: true
end
