class ApplicationMailer < ActionMailer::Base
  default from: "megurumee@gmail.com",
          bcc: "sent@gmail.com",
	  reply_to: "reply@gmail.com"
  layout 'mailer'
end

