class Identification < ApplicationRecord
  belongs_to :user

# validates :first_name, presence: true
# validates :last_name, presence: true
# validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
# validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
# validates :zip_code, format: {with: /\A\d{3}[-]\d{4}\z/ }, length: { maximum:8  }, allow_blank: true
# validates :birthday, presence: true
end
