Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :line, ENV['LINE_KEY'], ENV['LINE_SECRET']
provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET_KEY']
require 'omniauth/strategies/facebook_owner'
provider :facebook_owner, ENV['FACEBOOK_OWNER_ID'], ENV['FACEBOOK_OWNER_SECRET_KEY']

provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
require 'omniauth/strategies/twitter_owner'
provider :twitter_owner, ENV['TWITTER_OWNER_API_KEY'], ENV['TWITTER_OWNER_API_SECRET']

provider :line, ENV['LINE_KEY'], ENV['LINE_SECRET']
require 'omniauth/strategies/line_owner'
provider :line_owner, ENV['LINE_OWNER_KEY'], ENV['LINE_OWNER_SECRET']


# 以下のコードの必要性を調べる。
configure do |config|
  config.path_prefix = '/devise/auth'
end

on_failure do |env|
  #we need to setup env
  if env['omniauth.params'].present?
    env["devise.mapping"] = Devise.mappings[:user]
  else
    env["devise.mapping"] = Devise.mappings[:owner]
  end
  Devise::OmniauthCallbacksController.action(:failure).call(env)
end
end