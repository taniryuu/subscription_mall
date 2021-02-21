class CategorySubscription < ApplicationRecord
  belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  belongs_to :subscription, optional: true#belongs_toの外部キーのnilを許可
end
