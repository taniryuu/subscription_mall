class CategoryPrivateStore < ApplicationRecord
  belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  belongs_to :private_store, optional: true#belongs_toの外部キーのnilを許可
end
