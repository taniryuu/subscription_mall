class ContactMailer < ApplicationMailer
  default from: 'megurume@subscription.com'# 送信元アドレス

  def contact_email(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせを承りました')
  end
end
