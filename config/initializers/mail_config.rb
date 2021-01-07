ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: 'ruffini47@gmail.com',
  password: 'zjfawrodqaqsyidb',
  authentication: 'plain',
  enable_starttls_auto: true
}
