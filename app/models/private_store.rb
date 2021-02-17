class PrivateStore < ApplicationRecord
  belongs_to :owner
  # belongs_to :shop
  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :instablogs, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

  enum price: { "3,000"=> 1, "12,000"=> 2, "18,000"=> 3, "25,000"=> 4, "50,000"=> 5, "100,000"=> 6}, _prefix: true
  enum category_name: { "和食"=> 1, "洋食"=> 2, "中華"=> 3, "イタリアン"=> 4, "フレンチ"=> 5, "ハワイアン"=> 6, "東南アジア料理"=> 7, "鍋"=> 8, "丼モノ"=> 9, "韓国料理"=> 10, "スイーツ"=> 11, "その他"=> 12}, _prefix: true
  enum category_genre: { "カフェ"=> 1, "らーめん"=> 2, "パン屋"=> 3, "カレー"=> 4, "居酒屋"=> 5, "バー"=> 6, "ケーキ"=> 7, "焼肉"=> 8, "定食屋"=> 9, "ハンバーガー"=> 10, "レストラン"=> 11, "お好み焼き"=> 12, "唐揚げ"=> 13, "餃子"=> 14, "うどん"=> 15, "そば"=> 16}, _prefix: true
  # attachment :image_subscription
  mount_uploader :image_private_store, PrivateStoreUploader
  mount_uploader :image_private_store2, PrivateStoreUploader
  mount_uploader :image_private_store3, PrivateStoreUploader
  mount_uploader :image_private_store4, PrivateStoreUploader
  mount_uploader :image_private_store5, PrivateStoreUploader
  mount_uploader :sub_image, PrivateStoreUploader
  mount_uploader :sub_image2, PrivateStoreUploader
  mount_uploader :sub_image3, PrivateStoreUploader
  mount_uploader :sub_image4, PrivateStoreUploader
  mount_uploader :sub_image5, PrivateStoreUploader
  mount_uploader :sub_image6, PrivateStoreUploader
  mount_uploader :sub_image7, PrivateStoreUploader
  mount_uploader :sub_image8, PrivateStoreUploader
  mount_uploader :sub_image9, PrivateStoreUploader
  mount_uploader :sub_image10, PrivateStoreUploader
  mount_uploader :sub_image11, PrivateStoreUploader
  mount_uploader :sub_image12, PrivateStoreUploader
  mount_uploader :qr_image, PrivateStoreUploader


  validates :category_name, presence: true

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
end

