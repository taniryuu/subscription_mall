# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  # 決済通知
  def send_payment_email
    @user = User.first
    AdminMailer.with(user: @user).send_payment_email
  end

  # 利用者退会通知
  def cancel_email
    AdminMailer.cancel_email
  end
end
