class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2, :line, :instagram]

  def self.find_for_oauth(auth) # facebook, twitter ログイン用メソッドです
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  # has_many :social_profiles, dependent: :destroy
  #         user
  #       end

  has_many :social_profiles, dependent: :destroy # ここから44行目までline ログイン用メソッドです
  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end


  def set_values(omniauth)
      return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
      credentials = omniauth['credentials']
      info = omniauth['info']

      access_token = credentials['refresh_token']
      access_secret = credentials['secret']
      credentials = credentials.to_json
      name = info['name']
      # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
    user
  end


  private

    def self.dummy_email(auth)  # facebook, twitter ログイン用メソッドです
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
