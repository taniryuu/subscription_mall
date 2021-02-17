class Subscription < ApplicationRecord
  belongs_to :owner
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :instablogs, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :category_id, presence: true

  geocoded_by :address
  after_validation :geocode
  enum price: { "3,000"=> 1, "12,000"=> 2, "18,000"=> 3, "25,000"=> 4, "50,000"=> 5, "100,000"=> 6}, _prefix: true
  # enum category_name: { "和食"=> 1, "定食屋"=> 2, "らーめん"=> 3, "カフェ"=> 4, "パン屋"=> 5, "居酒屋"=> 6, "イタリアン"=> 7, "中華"=> 8, "フレンチ"=> 9, "ハワイアン"=> 10, "東南アジア料理"=> 11, "バー"=> 12, "ケーキ"=> 13, "焼肉"=> 14, "洋食"=> 15, "カレー"=> 16, "ハンバーガー"=> 17, "韓国料理"=> 18, "レストラン"=> 19, "お好み焼き"=> 20, "鍋"=> 21, "スイーツ"=> 22, "唐揚げ"=> 23, "餃子"=> 24, "丼モノ"=> 25, "うどん"=> 26, "そば"=> 27, "その他"=> 28}, _prefix: true
  # enum category_genre: { "カフェ"=> 1, "らーめん"=> 2, "パン屋"=> 3, "カレー"=> 4, "居酒屋"=> 5, "バー"=> 6, "ケーキ"=> 7, "焼肉"=> 8, "定食屋"=> 9, "ハンバーガー"=> 10, "レストラン"=> 11, "お好み焼き"=> 12, "唐揚げ"=> 13, "餃子"=> 14, "うどん"=> 15, "そば"=> 16}, _prefix: true
  # attachment :image_subscription
  mount_uploader :image_subscription, SubscriptionUploader
  mount_uploader :image_subscription2, SubscriptionUploader
  mount_uploader :image_subscription3, SubscriptionUploader
  mount_uploader :image_subscription4, SubscriptionUploader
  mount_uploader :image_subscription5, SubscriptionUploader
  mount_uploader :sub_image, SubscriptionUploader
  mount_uploader :sub_image2, SubscriptionUploader
  mount_uploader :sub_image3, SubscriptionUploader
  mount_uploader :sub_image4, SubscriptionUploader
  mount_uploader :sub_image5, SubscriptionUploader
  mount_uploader :sub_image6, SubscriptionUploader
  mount_uploader :sub_image7, SubscriptionUploader
  mount_uploader :sub_image8, SubscriptionUploader
  mount_uploader :sub_image9, SubscriptionUploader
  mount_uploader :sub_image10, SubscriptionUploader
  mount_uploader :sub_image11, SubscriptionUploader
  mount_uploader :sub_image12, SubscriptionUploader
  mount_uploader :qr_image, SubscriptionUploader



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
