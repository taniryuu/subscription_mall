class Category < ApplicationRecord
  # belongs_to :user
  # belongs_to :owner
  # enum name: { "和食"=> 1, "洋食"=> 2, "中華"=> 3, "イタリアン"=> 4, "フレンチ"=> 5, "ハワイアン"=> 6, "東南アジア料理"=> 7, "韓国料理"=> 8, "その他"=> 9}, _prefix: true
  # enum genre: { "カフェ"=> 1, "らーめん"=> 2, "パン屋"=> 3, "カレー"=> 4, "居酒屋"=> 5, "BAR"=> 6, "ケーキ"=> 7, "焼肉"=> 8, "定食屋"=> 9, "バーガー"=> 10, "レストラン"=> 11, "その他"=> 12}, _prefix: true

  def self.search(search) #ここでのself.はCategory.を意味する
    if search
      where(['name LIKE ?', "%#{search}%"])#検索とnameの部分一致を表示。Category.は省略
    else
      all #全て表示。Category.は省略
    end
  end
end
