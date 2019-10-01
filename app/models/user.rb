class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many  :sell_transacts, class_name: 'Transact', foreign_key: :seller_id
  has_many  :buy_transacts, class_name: 'Transact', foreign_key: :buyer_id
  has_many  :sell_items, class_name: 'Item', through: :sell_transacts, source: :item
  has_many  :buy_items, class_name: 'Item', through: :buy_transacts, source: :item
          
  # validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
  validates :password, presence: true, length: { minimum: 7 ,maximum:128 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # 空白がないことを確認、emailのフォーマットの検証、一意性の検証
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX },uniqueness: true
  before_save { self.email = email.downcase }
end
