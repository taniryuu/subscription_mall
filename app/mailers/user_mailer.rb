class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email#会員登録してくれた方へ登録感謝のメール。送信処理は未実装
    @user = params[:user]
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: '巡グルメへの会員登録ありがとうございます！')
  end

  def cancel_email(user) # ユーザー,オーナー退会時メール
    @user = user
    mail(to: @user.email, subject: "退会通知")
  end
end
