class Item < ApplicationRecord
  has_many    :images
  has_one     :transact
  accepts_nested_attributes_for :transact
  belongs_to  :category
  belongs_to  :sizing
  enum        condition: {
    unused: 0,
    fresh:  1,
    normal: 2,
    poor:   3,
    dirty:  4,
    bad:    5
  }
end
