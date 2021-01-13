class ApplicationMailer < ActionMailer::Base
  default from:     "巡グルメ",
          bcc:      "sent@gmail.com",
          reply_to: "reply@gmail.com"
  layout 'mailer'
end

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
end
