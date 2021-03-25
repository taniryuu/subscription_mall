# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def send_payment_email
    @user = User.first
    AdminMailer.with(user: @user).send_payment_email
  end
end
