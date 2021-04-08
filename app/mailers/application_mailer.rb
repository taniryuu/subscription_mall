class ApplicationMailer < ActionMailer::Base
  default from: ENV['SEND_MAIL']
  layout 'mailer'
end

