class UserMailer < ApplicationMailer
  default from: 'megurumee@gmail.com'

  def welcome_email # ユーザーへ入会welcomeメール
    @user = params[:user]
    @url  = 'https://www.megurumee.com/users/sign_in'
    mail(to: @user.email, subject: 'アカウントの登録を受け付けました。')
  end

  def notice_user_joining_email # 管理者へユーザー入会通知メール
    @user = params[:user]
    @url  = 'https://www.megurumee.com/admins/sign_in' 
    mail(to: 'megurumee@gmail.com', subject: '利用者アカウントの新規登録がありました。')
  end

  def cancel_email(user) # ユーザー,オーナー退会時メール
    @user = user
    mail(to: @user.email, subject: "退会通知")
  end

end
