class Adress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :prefecture, class_name: "Prefecture"

validates :first_name, presence: true
validates :last_name, presence: true
validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
validates :zip_code, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/ }, length: { maximum: 8  }
validates :prefecture_id, presence: true
validates :city, presence: true
validates :street, presence: true
end
