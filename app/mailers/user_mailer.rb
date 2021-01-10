class UserMailer < ApplicationMailer
  default from: 'megurumee@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'アカウントの登録を受け付けました。')
  end
end
