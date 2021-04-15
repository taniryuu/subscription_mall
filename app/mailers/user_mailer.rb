class UserMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']

  def welcome_email # ユーザーへ入会welcomeメール
    @user = params[:user]
    @url  = 'https://www.megurumee.com/users/sign_in'
    mail(to: @user.email, subject: 'アカウントの登録を受け付けました。')
  end

  def notice_user_joining_email # 管理者へユーザー入会通知メール
    @user = params[:user]
    @url  = 'https://www.megurumee.com/admins/sign_in' 
    mail(to: ENV['SEND_MAIL'], subject: '利用者アカウントの新規登録がありました。')
  end

  def cancel_email(user) # ユーザー,オーナー退会時メール
    @user = user
    mail(to: @user.email, subject: "退会通知")
  end

  def user_subscription_email # 加盟店、利用者から経営者へメール送信
    @subscription = params[:subscription]
    @user = params[:user]
    @owner = Owner.find_by(id: @subscription.owner_id)
    @url  = 'https://www.megurumee.com/owners/sign_in' 
    mail(to: @subscription.email, subject: '利用者様からのお問い合わせがあります')
  end

  def user_private_store_email #個人店利用者から経営者へメール送信
    @private_store = params[:private_store]
    @user = params[:user]
    @owner = Owner.find_by(id: @private_store.owner_id)
    @url  = 'https://www.megurumee.com/owners/sign_in' 
    mail(to: @private_store.email, subject: '利用者様からのお問い合わせがあります')
  end

end
