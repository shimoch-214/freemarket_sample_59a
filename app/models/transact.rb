class Transact < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # associations
  belongs_to  :item
  belongs_to  :seller, class_name: 'User', foreign_key: :seller_id
  belongs_to  :buyer, class_name: 'User', foreign_key: :buyer_id, optional: true
  belongs_to_active_hash :prefecture
  has_many    :messages

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
    complete:    4
  }

  # validations
  validates_presence_of :item
  validates_presence_of :seller
  validates_presence_of :prefecture
  validates :bearing, presence: true
  validate  :status_has_to_be_zero, on: :create 
  validates :delivery_method, presence: true
  validates :ship_days, presence: true
  validate  :valid_delivery_method, if: :bearing? && :delivery_method?

  # custom validate
  def valid_delivery_method
    if bearing == 'buyer_side'
      unless Transact.delivery_methods_for_buyer_side.keys.include?(delivery_method)
        errors.add(:delivery_method)
      end
    end
  end

  def status_has_to_be_zero
    if status_before_type_cast.to_i != 0
      errors.add(:status)
    end
  end

  # methods
  def self.delivery_methods_for_buyer_side
    Transact.delivery_methods.slice(:pending, :yu_mail, :yu_pack, :kuroneko)
  end

end
