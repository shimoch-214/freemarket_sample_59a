class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_one                       :identification, inverse_of: :user, class_name: 'Identification', dependent: :destroy
  accepts_nested_attributes_for :identification
  has_one                       :address, inverse_of: :user, dependent: :destroy, class_name: 'Address'
  accepts_nested_attributes_for :address
  has_one   :sns_confirmation, class_name: 'SnsConfirmation', dependent: :destroy
  accepts_nested_attributes_for :sns_confirmation
  has_many  :sell_transacts, class_name: 'Transact', foreign_key: :seller_id
  has_many  :buy_transacts, class_name: 'Transact', foreign_key: :buyer_id
  has_many  :sell_items, class_name: 'Item', through: :sell_transacts, source: :item
  has_many  :buy_items, class_name: 'Item', through: :buy_transacts, source: :item

  before_save { self.email = email.downcase }

  # validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
  # validates :password, presence: true, length: { minimum: 7 ,maximum:128 }
  # validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: true
  # validates :phone_number, presence: true, format: { with: /\A0[7-9]0-?\d{4}-?\d{4}\z/ }, length: { minimum:11 ,maximum:11},uniqueness: {case_sensitive:false}
  # validates :profile, length: {maximum:1000},allow_blank: true         

  # methods for omniauth
  def self.from_omniauth(auth)
    sns = SnsConfirmation.where(provider: auth.provider, uid: auth.uid).first
    if sns.nil?
      sns = SnsConfirmation.new(provider: auth.provider,
                                uid: auth.uid,
                                email: auth.info.email)
      user = new(email: auth.info.email)
      user.sns_confirmation = sns
    end
    sns.user
  end


  def password_required?
    super && sns_confirmation.nil?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    end
  end

end
