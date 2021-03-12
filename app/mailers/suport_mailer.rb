class SuportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.suport_mailer.suport_mail.subject
  #
  default from: 'megurumee@gmail.com'# 送信元アドレス

  def suport_email(suport)
    @suport = suport
    mail(:to => suport.email, :subject => 'サポートのお問い合わせを承りました')
  end

  def get_suport_email(suport)
    @suport = suport
    mail(:to => 'megurumee@gmail.com', :subject => 'サポートのお問い合わが入りました。ご確認をお願いいたします。')
  end
end
