class Subscription < ApplicationRecord
  belongs_to :owner
  # belongs_to :user, optional: true#belongs_toの外部キーのnilを許可
  # belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  has_many :category_subscriptions, dependent: :destroy
  has_many :categories, through: :category_subscriptions
  accepts_nested_attributes_for :categories, allow_destroy: true

  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :instablogs, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 1000 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :detail, presence: true, length: { maximum: 100 }
  validates :shop_introduction, presence: true, length: { maximum: 1000 }
  validates :subscription_detail, presence: true, length: { maximum: 1000 }
  validates :image_subscription, presence: true, allow_blank: true
  # validates :qr_image, presence: true
  validates :category_ids, presence: true, allow_blank: true
  validates :price, presence: true

  geocoded_by :address
  after_validation :geocode

  #enum category_name: { "和食"=> 1, "洋食"=> 2, "中華"=> 3, "イタリアン"=> 4, "フレンチ"=> 5, "ハワイアン"=> 6, "東南アジア料理"=> 7, "鍋"=> 8, "丼モノ"=> 9, "韓国料理"=> 10, "スイーツ"=> 11, "その他"=> 12}, _prefix: true
  #enum category_genre: { "カフェ"=> 1, "らーめん"=> 2, "パン屋"=> 3, "カレー"=> 4, "居酒屋"=> 5, "バー"=> 6, "ケーキ"=> 7, "焼肉"=> 8, "定食屋"=> 9, "ハンバーガー"=> 10, "レストラン"=> 11, "お好み焼き"=> 12, "唐揚げ"=> 13, "餃子"=> 14, "うどん"=> 15, "そば"=> 16}, _prefix: true
  enum price: { "3000"=> 1, "9000"=> 2, "11000"=> 3, "18000"=> 4, "25000"=> 5, "50000"=> 6, "100000"=> 7}, _prefix: true
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
