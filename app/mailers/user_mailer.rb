class UserMailer < ApplicationMailer
  default from: 'megurumee@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'アカウントの登録を受け付けました。')
  end



  def cancel_email(user) # ユーザー,オーナー退会時メール
    @user = user
    mail(to: @user.email, subject: "退会通知")
  end

end
