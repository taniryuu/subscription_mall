class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :ticket, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :megurumereviews, dependent: :destroy
  has_many :user_plans, dependent: :destroy
  acts_as_paranoid # 追加
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable
        #  :validatable,
        #  :omniauthable,
        # omniauth_providers: [:facebook, :twitter, :google_oauth2, :line, :instagram]

  scope :without_soft_deleted, -> { where(deleted_at: nil) }
  # validatable相当の検証を追加
  validates_uniqueness_of :email, scope: :deleted_at
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
  # validates :kana, presence: true
  validates_format_of :email, presence: true, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create # 6..128
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update
  
  validate :user_password_regex, on: :create
  
  # バリデーションメソッド
  def user_password_regex
    if password !~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,128}+\z/i # バリデーションの条件
      errors.add(:password, "は6以上で、半角英字と半角数字を組み合わせてください。") # エラーメッセージ
    end
  end

  # @see https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_deleted.where(conditions.to_h).first
  end

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

  # 物理削除の代わりにユーザーの`deleted_at`をタイムスタンプで更新
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ユーザーのアカウントが有効であることを確認
  def active_for_authentication?
    super && !deleted_at
  end

  # 削除したユーザーにカスタムメッセージを追加します
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def subscribed?
    session_id?
  end

  # ユーザーの名前であいまい検索
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end  

  private

    def self.dummy_email(auth)  # facebook, twitter ログイン用メソッドです
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
