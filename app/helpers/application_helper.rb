module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Subscription_mall"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  # 渡された管理者がログイン済みの管理者であればtrueを返します。
  def current_admin?(admin)
    admin == current_admin
  end

  # 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
  def current_user?(user)
    user == current_user
  end

  # 渡された経営者がログイン済みの経営者であればtrueを返します。
  def current_owner?(owner)
    owner == current_owner
  end

end
