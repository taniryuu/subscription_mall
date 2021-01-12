class Megurumereview < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 150 }
  validates :score, presence: true, allow_blank: true

end
