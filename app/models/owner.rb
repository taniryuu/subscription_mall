class Owner < ApplicationRecord
  # has_many :shops, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  # has_many :interviews, dependent: :destroy

  acts_as_paranoid # 追加

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable
        #  :validatable

  scope :without_soft_deleted, -> { where(deleted_at: nil) }
  # validatable相当の検証を追加
  validates_uniqueness_of :email, scope: :deleted_at
  validates :name, presence: true
  # validates :kana, presence: true
  validates_format_of :email, presence: true, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update

  # @see https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_deleted.where(conditions.to_h).first
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
