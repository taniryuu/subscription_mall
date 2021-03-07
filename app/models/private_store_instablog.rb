class PrivateStoreInstablog < ApplicationRecord
  belongs_to :private_store
  validates :insta_content, presence: true
end
