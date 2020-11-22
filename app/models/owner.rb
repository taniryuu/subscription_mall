class Owner < ApplicationRecord
  has_many :shops, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  # has_many :interviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
