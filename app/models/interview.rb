class Interview < ApplicationRecord
  # belongs_to :owner
  mount_uploader :image_interview, InterviewUploader
end
