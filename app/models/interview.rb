class Interview < ApplicationRecord
  # belongs_to :owner
  mount_uploader :image_interview, InterviewUploader
  validates :owner_name, presence: true, length: { maximum: 50 }
  validates :shop_name, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image_interview , presence: true
end
