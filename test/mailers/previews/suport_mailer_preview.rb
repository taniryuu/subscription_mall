# Preview all emails at http://localhost:3000/rails/mailers/suport_mailer
class SuportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/suport_mailer/suport_mail
  def suport_mail
    SuportMailer.suport_mail
  end

end
