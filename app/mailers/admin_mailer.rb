class AdminMailer < ApplicationMailer
  default to: Admin.first.email

  # 利用者決済通知
  def send_payment_email(user)
    @user = user
    mail(subject: "巡グルメのstripeで決済が行われました")
  end

  # 利用者退会通知
  def cancel_email
    mail(subject: "利用者が退会しました")
  end
end
