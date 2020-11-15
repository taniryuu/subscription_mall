class Shop < ApplicationRecord
  belongs_to :owner

  enum monthly_fee: { "1980"=> 0, "4980"=> 1, "19800"=> 2}
end
