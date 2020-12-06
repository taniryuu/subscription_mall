class SuportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.suport_mailer.suport_mail.subject
  #
  default from: 'megurume@subscription.com'# 送信元アドレス

  def suport_email(suport)
    @suport = suport
    mail(:to => suport.email, :subject => 'サポートのお問い合わせを承りました')
  end
end
