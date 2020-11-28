class Suport < ApplicationRecord
  # belongs_to :user
  # belongs_to :owner
  attr_accessor :name, :email, :message

  validates :name, :presence => {:message => '名前を入力してください'}
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}  
end
