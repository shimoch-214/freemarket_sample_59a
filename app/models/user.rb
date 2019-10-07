class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_one                       :identification, inverse_of: :user
accepts_nested_attributes_for :identification
has_one                       :adress, inverse_of: :user
accepts_nested_attributes_for :adress
has_many  :sell_transacts, class_name: 'Transact', foreign_key: :seller_id
has_many  :buy_transacts, class_name: 'Transact', foreign_key: :buyer_id
has_many  :sell_items, class_name: 'Item', through: :sell_transacts, source: :item
has_many  :buy_items, class_name: 'Item', through: :buy_transacts, source: :item

before_save { self.email = email.downcase }

validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
validates :password, presence: true, length: { minimum: 7 ,maximum:128 }
validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: true
validates :phone_number, presence: true, format: { with: /\A0[7-9]0-?\d{4}-?\d{4}\z/ }, length: { minimum:11 ,maximum:11},uniqueness: {case_sensitive:false}
validates :profile, length: {maximum:1000},allow_blank: true         

end
