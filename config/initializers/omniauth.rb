Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :line, ENV['LINE_KEY'], ENV['LINE_SECRET']
provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET_KEY']
end