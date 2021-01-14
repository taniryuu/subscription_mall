module OmniAuth
  module Strategies
    class TwitterOwner < OmniAuth::Strategies::Twitter
      option :name, 'twitter_owner'
    end
  end
end