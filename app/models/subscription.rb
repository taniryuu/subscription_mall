class Subscription < ApplicationRecord
  belongs_to :owner
  belongs_to :shop
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  enum price: { "3,000"=> 0, "12,000"=> 1, "18,000"=> 2, "25,000"=> 3, "50,000"=> 4, "100,000"=> 5}, _prefix: true
  enum category_name: { "和食"=> 1, "洋食"=> 2, "中華"=> 3, "イタリアン"=> 4, "フレンチ"=> 5, "ハワイアン"=> 6, "東南アジア料理"=> 7, "韓国料理"=> 8, "その他"=> 9}, _prefix: true
  enum category_genre: { "カフェ"=> 1, "らーめん"=> 2, "パン屋"=> 3, "カレー"=> 4, "居酒屋"=> 5, "BAR"=> 6, "ケーキ"=> 7, "焼肉"=> 8, "定食屋"=> 9, "バーガー"=> 10, "レストラン"=> 11, "その他"=> 12}, _prefix: true
  # attachment :image_subscription

  mount_uploader :image_subscription, ImageUploader
  mount_uploader :image_subscription2, ImageUploader
  mount_uploader :image_subscription3, ImageUploader
  mount_uploader :image_subscription4, ImageUploader
end
