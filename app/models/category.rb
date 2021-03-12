class Category < ApplicationRecord
  # has_many :subscriptions

  has_many :category_subscriptions
  has_many :subscriptions, through: :category_subscriptions
  has_many :category_private_stores
  has_many :private_stores, through: :category_private_stores
  # mount_uploader :image_category, CategoryUploader

  def self.search(search) #ここでのself.はCategory.を意味する
    if search
      where(['name LIKE ?', "%#{search}%"])#検索とnameの部分一致を表示。Category.は省略
    else
      all #全て表示。Category.は省略
    end
  end
end
