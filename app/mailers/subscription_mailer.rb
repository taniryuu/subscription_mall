class SubscriptionMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']

  def notification_email
    @subscription = params[:subscription]
    @owner = Owner.find_by(id: @subscription.owner_id)
    @new = params[:new]
    @url  = 'https://www.megurumee.com/'
    if @new == "true"
      mail(to: ENV['SEND_MAIL'], subject: '加盟店舗の審査申請されました')
    else
      mail(to: ENV['SEND_MAIL'], subject: '加盟店舗が編集されました')
    end
  end

  def judging_email
    @subscription = params[:subscription]
    @owner = Owner.find_by(id: @subscription.owner_id)
    @new = params[:new]
    @url  = 'https://www.megurumee.com/'
    if @new == "承認"
      mail(to: @owner.email, subject: '審査結果報告')
    else
      mail(to: @owner.email, subject: '加盟店舗が編集されました')
    end
  end

  def takeout_email
    @user = User.find(params[:id])
    @subscription = Subscription.find(params[:subscription_id])
    mail(to: @subscription.email, subject: "テイクアウトの注文が入りました")
  end
end
