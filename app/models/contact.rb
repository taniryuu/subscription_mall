class Contact < ApplicationRecord
  # belongs_to :user
  # belongs_to :owner
  attr_accessor :name, :email, :message

  validates :name, :presence => {:message => '名前を入力してください'}, length: { minimum: 2,:message => '名前を２文字以上で入力してください'}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX,:message => '入力されたメールアドレスは不正な値です' }  
  validates :message, :presence => {:message => 'お問い合わせ内容を入力してください'}, length: { maximum: 255, :message => 'お問い合わせ内容は255文字以内で書いてください' }

end
