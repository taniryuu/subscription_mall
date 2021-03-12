class Question < ApplicationRecord

  validates :detail, presence: true, length: { in: 5..1000 }
  validates :answer, presence: true, length: { in: 5..1000 }
end
