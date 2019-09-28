class Transact < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to  :item
  belongs_to  :seller,  class_name: 'User', foreign_key: :seller_id
  belongs_to  :buyer,   class_name: 'User', foreign_key: :buyer_id, optional: true
  belongs_to_active_hash :prefecture
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
end
