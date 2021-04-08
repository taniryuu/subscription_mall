class ContactMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']# 送信元アドレス

  # 利用者へお問い合わせサンキューメール送信
  def contact_email(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせを承りました')
  end

  # 管理者へお問い合わせが入った通知メール送信
  def get_contact_email(contact)
    @contact = contact
    mail(:to => ENV['SEND_MAIL'], :subject => 'お問い合わせが入りました。ご確認をお願いいたします。')
  end 
end
