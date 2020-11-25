class ContactMailer < ApplicationMailer
  default from: 'megurume@subscription.com'

  def contact_email
    @contact = params[:contact]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: '私の素敵なサイトへようこそ')
  end
end
