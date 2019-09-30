class Item < ApplicationRecord

  # associations
  has_many    :images, dependent: :destroy
  has_one     :transact, dependent: :destroy, class_name: 'Transact', inverse_of: :item
  accepts_nested_attributes_for :transact
  belongs_to  :category
  belongs_to  :sizing, optional: true
  delegate    :seller, :buyer, to: :transact

  # enum setting
  enum        condition: {
    unused: 0,
    fresh:  1,
    normal: 2,
    poor:   3,
    dirty:  4,
    bad:    5
  }

  # validations
  validates_presence_of :transact
  validates :price, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than: 10000000
  }
  validates :name, length: { in: 1..40 }
  validates :description, length: { in: 1..1000 }
  validates :category_id, presence: true
  validate  :category_cannot_have_children, if: :category_id?
  validate  :presence_of_sizeing_if_category_has_size, if: :category_id?
  validate  :sizing_has_to_be_child, if: :sizing_id?

  # custom validate
  def category_cannot_have_children
    if category.has_children?
      errors.add(:category_id)
    end
  end

  def presence_of_sizeing_if_category_has_size
    if category.sizing
      unless sizing
        errors.add(:sizing_id)
      end
    end
  end

  def sizing_has_to_be_child
    if sizing.is_root?
      errors.add(:sizing_id)
    end
  end

  # method

end
