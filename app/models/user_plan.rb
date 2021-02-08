class UserPlan < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  validates :user_id, uniquness: { scope: :subscription_id }
end
