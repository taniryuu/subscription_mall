class PrivateStore < ApplicationRecord
  belongs_to :owner
  belongs_to :category, optional: true#belongs_toの外部キーのnilを許可
  #has_many :category_private_stores, dependent: :destroy
  #has_many :categories, through: :category_private_stores
  #accepts_nested_attributes_for :categories, allow_destroy: true

  has_many :reviews, dependent: :destroy
  has_many :private_store_instablogs, dependent: :destroy
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 1000 }, on: :update
  validates :title, length: { maximum: 100 }, on: :update
  validates :detail, length: { maximum: 100 }, on: :update
  validates :private_store_detail, length: { maximum: 1000 }, on: :update
  # validates :category_id, presence: true, on: :update
  # validates :ordinal, presence: true, uniqueness: true, numericality: :only_integer
  # validates :product_id, presence: true, allow_blank: true

  geocoded_by :address
  after_validation :geocode
  #enum price: { "3000"=> 1, "9000"=> 2, "11000"=> 3, "18000"=> 4, "25000"=> 5, "50000"=> 6, "100000"=> 7}, _prefix: true
  mount_uploader :image_private_store, PrivateStoreUploader
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

