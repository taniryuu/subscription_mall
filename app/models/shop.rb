class Shop < ApplicationRecord
  belongs_to :owner
  has_one :subscription, dependent: :destroy #shop_idを追加で１対１の関係

  enum monthly_fee: { "1980"=> 0, "4980"=> 1, "19800"=> 2}
end
