class Subscription < ApplicationRecord
  belongs_to :owner
  belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  # has_many :categories, through: :category_subscriptions
  # has_many :category_subscriptions

  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :instablogs, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 1000 }
  # validates :title, presence: true, length: { maximum: 100 }
  # validates :detail, presence: true, length: { maximum: 100 }
  # validates :shop_introduction, presence: true, length: { maximum: 1000 }
  # validates :subscription_detail, presence: true, length: { maximum: 1000 }
  # validates :image_subscription, presence: true
  validates :category_id, presence: true
  validates :price, presence: true

  geocoded_by :address
  after_validation :geocode
  enum price: { "3,000"=> 1, "12,000"=> 2, "18,000"=> 3, "25,000"=> 4, "50,000"=> 5, "100,000"=> 6}, _prefix: true
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
