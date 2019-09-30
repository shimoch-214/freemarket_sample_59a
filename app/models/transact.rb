class Transact < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # associations
  belongs_to  :item
  belongs_to  :seller,  class_name: 'User', foreign_key: :seller_id
  belongs_to  :buyer,   class_name: 'User', foreign_key: :buyer_id, optional: true
  belongs_to_active_hash :prefecture

  # enum setting
  enum delivery_method: {
    pending:      0,
    mercari_post: 1,
    yu_mail:      2,
    letter_pack:  3,
    reqular_post: 4,
    kuroneko:     5,
    yu_pack:      6,
    click_post:   7,
    yu_packet:    8
  }
  enum bearing: {
    seller_side: false,
    buyer_side:  true
  }
  enum ship_days: {
    short:       0,
    medium:      1,
    long:        2
  }
  enum status: {
    exhibit:     0,
    contract:    1,
    shipped:     2,
    arrived:     3,
    thanks:      4,
    complete:    5
  }

  # validations
  validates_presence_of :item
  validates :seller_id, presence: true
  validates :bearing, presence: true
  validates :delivery_method, presence: true
  validates :prefecture_id, presence: true
  validates :ship_days, presence: true
  validate  :valid_delivery_method, if: :bearing? && :delivery_method?

  # custom validate
  def valid_delivery_method
    if bearing == 'seller_side'
      unless Transact.delivery_methods_for_seller.keys.include?(delivery_method)
        errors.add(:delivery_method)
      end
    end
  end

  # methods
  def self.delivery_methods_for_seller
    Transact.delivery_methods.slice(:pending, :yu_mail, :yu_pack, :kuroneko)
  end

end
