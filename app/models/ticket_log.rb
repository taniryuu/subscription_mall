class TicketLog < ApplicationRecord
  # belongs_to :ticket

  def self.search(owner_name) #ここでのself.はTicketLog.を意味する
    if owner_name
      where(['owner_name LIKE ?', "%#{owner_name}%"])#検索とnameの部分一致を表示。Category.は省略
    else
      none.paginate(page: params[:page], per_page: 10) #全て表示。Category.は省略
    end
  end
end
