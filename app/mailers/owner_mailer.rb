class OwnerMailer < ApplicationMailer
  default from: 'megurumee@gmail.com'

  def welcome_email
    @owner = params[:owner]
    @url  = 'http://example.com/login'
    mail(to: @owner.email, subject: 'アカウントの登録を受け付けました。')
  end
end
