class ContactMailer < ApplicationMailer
  default from: 'megurume@subscription.com'# 送信元アドレス

  def contact_email(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせを承りました')
  end

  # 管理者へお問い合わせが入った通知メール
  def get_contact_email(contact)
    @contact = contact
    mail(:to => 'p.aaattt25@gmail.com', :subject => 'お問い合わせが入りました。ご確認をお願いいたします。')
  end 
end
