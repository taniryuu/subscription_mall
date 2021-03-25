class AdminMailer < ApplicationMailer
  def send_payment_email(user)
    @user = user
    mail(to: Admin.first.email, subject: "巡グルメのstripeで決済が行われました")
  end
end
