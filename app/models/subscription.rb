class Subscription < ApplicationRecord
  belongs_to :owner
  # belongs_to :user, optional: true#belongs_toの外部キーのnilを許可
  belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  # has_many :category_subscriptions, dependent: :destroy
  # has_many :categories, through: :category_subscriptions
  # accepts_nested_attributes_for :categories, allow_destroy: true

  has_many :reviews, dependent: :destroy
  has_many :instablogs, dependent: :destroy
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  # validates :site, presence: true
  # validates :address, presence: true, length: { maximum: 1000 }, on: :create
  # validates :title, presence: true, length: { maximum: 100 }, on: :create
  # validates :detail, presence: true, length: { maximum: 100 }, on: :create
  # validates :shop_introduction, presence: true, length: { maximum: 1000 }, on: :create
  # validates :subscription_detail, presence: true, length: { maximum: 1000 }, on: :create
  # validates :image_subscription, presence: true, allow_blank: true, on: :create
  # validates :qr_image, presence: true, allow_blank: true, on: :create
  # validates :category_id, presence: true, allow_blank: true, on: :create
  # validates :price, presence: true, on: :create
  #validates :trial, presence: true


  geocoded_by :address
  after_validation :geocode

  enum price: { "1000" => 0, "3000"=> 1, "9000"=> 2, "11000"=> 3, "18000"=> 4, "25000"=> 5, "50000"=> 6, "100000"=> 7}, _prefix: true
  # attachment :image_subscription
  mount_uploader :image_subscription, SubscriptionUploader
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
