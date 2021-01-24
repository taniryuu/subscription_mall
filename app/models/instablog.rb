class Instablog < ApplicationRecord
  belongs_to :subscription
  validates :insta_content, presence: true
end
