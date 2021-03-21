class Owner < ApplicationRecord
  # has_many :shops, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :private_stores, dependent: :destroy
  has_many :category_subscriptions, dependent: :destroy
  # has_many :interviews, dependent: :destroy

  acts_as_paranoid without_default_scope: true
  after_destroy      :update_document_in_search_engine
  after_restore      :update_document_in_search_engine
  after_real_destroy :remove_document_from_search_engine


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable
	# :confirmable
        #  :validatable

  scope :without_soft_deleted, -> { where(deleted_at: nil) }
  # validatable相当の検証を追加
  validates_uniqueness_of :email, scope: :deleted_at
  validates :name, presence: true, length: { minimum: 2 }
  # validates :kana, presence: true
  validates_format_of :email, presence: true, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
  # validate :owner_password_regex, on: :create
  # validate :owner_phone_number_regex

  # パスワードバリデーションメソッド
  def owner_password_regex
    if password !~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,128}+\z/i
      errors.add(:password, "は6文字以上で、半角英字と半角数字を組み合わせてください。") # エラーメッセージ
    end
  end

  def owner_phone_number_regex
    if phone_number !~ /\A[0-9]+\z/
      errors.add(:phone_number, "はハイフン無しで、半角数字のみを入力して下さい。") # エラーメッセージ
    end
  end


  # @see https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_deleted.where(conditions.to_h).first
  end

  def self.find_for_oauth(auth) # facebook, twitter ログイン用メソッドです
    owner = Owner.where(uid: auth.uid, provider: auth.provider).first
    unless owner
      begin
        owner = Owner.create(
          uid:      auth.uid,
          provider: auth.provider,
          email:    auth.info.email,
          name:  auth.info.name,
          password: Devise.friendly_token[0, 20]
        )
      owner.save(:validate => false)
      rescue StandardError => error
        owner
      end
    end
    owner
  end

  has_many :social_profiles, dependent: :destroy # ここから44行目までline ログイン用メソッドです
  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end


  def set_values(omniauth)
      return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
      credentials = omniauth['credentials']
      info = omniauth['info']

    self.access_token = credentials['refresh_token']
    self.access_secret = credentials['secret']
    self.credentials = credentials.to_json
    self.name = info['name']
    self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
    owner
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

end
