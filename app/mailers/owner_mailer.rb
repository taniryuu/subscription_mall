class OwnerMailer < ApplicationMailer

  def owner_email(user)
    @user = user
    mail(:to => @user.email, :subject => 'メッセージが届きました')
  end
  
end
