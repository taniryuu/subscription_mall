class Blog < ApplicationRecord
  # belongs_to :admin
  mount_uploader :image_photo, BlogUploader
  validates :title, presence: true, length: { maximum: 500 }
  validates :body, presence: true, length: { maximum: 1000 }
end
