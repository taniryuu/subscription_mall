class Review < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 4 }, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }
  validates :score, presence: true, allow_blank: true
end
