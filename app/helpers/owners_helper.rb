module OwnersHelper
  # サブスクのカラムがnilの場合、「未設定」を返す。それ以外は値を返す。
  def check_not_set(subscription_culumn)
    if subscription_culumn == nil
      return "未設定"
    else
      return subscription_culumn
    end
  end
end
