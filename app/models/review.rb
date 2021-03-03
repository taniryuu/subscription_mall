class Review < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }
  validates :score, presence: true, allow_blank: true
end
