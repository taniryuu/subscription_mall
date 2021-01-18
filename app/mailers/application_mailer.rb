class ApplicationMailer < ActionMailer::Base
  default from: "megurumee@gmail.com",
          bcc: "sent@gmail.com",
	  reply_to: "reply@gmail.com"
  layout 'mailer'
end
#send-welcome-email-with-devise

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
end

