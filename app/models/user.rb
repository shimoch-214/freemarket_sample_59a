class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_one                       :identification, inverse_of: :user
accepts_nested_attributes_for :identification
has_one                       :adress, inverse_of: :user
accepts_nested_attributes_for :adress
         
before_save { self.email = email.downcase }

validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
validates :password, presence: true, length: { minimum: 7 ,maximum:128 }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# 空白がないことを確認、emailのフォーマットの検証、一意性の検証
validates :email, presence: true, format: {with: VALID_EMAIL_REGEX },uniqueness: true         
end
