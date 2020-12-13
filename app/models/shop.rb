class Shop < ApplicationRecord
  belongs_to :owner
  has_one :subscription, dependent: :destroy #shop_idを追加で１対１の関係

  enum monthly_fee: { "1980"=> 1, "4980"=> 2, "19800"=> 3}
end
