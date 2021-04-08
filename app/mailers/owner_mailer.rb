class OwnerMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']

  def welcome_email
    @owner = params[:owner]
    @url  = 'https://www.megurumee.com/owners/sign_in'
    mail(to: @owner.email, subject: 'アカウントの登録を受け付けました。')
  end

  def notice_owner_joining_email # 管理者へユーザー入会通知メール
    @owner = params[:owner]
    @url  = 'https://www.megurumee.com/admins/sign_in'
    mail(to: 'megurumee@gmail.com', subject: 'アカウントの登録を受け付けました。')
  end
end
