class OwnerMailer < ApplicationMailer

  def owner_email(user, owner)
    @user = user
    @owner = owner
    mail(:to => @owner.email, :subject => '#{@owner.name}様からメッセージが届きました')
  end
  
end
