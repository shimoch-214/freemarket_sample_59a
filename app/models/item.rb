class Item < ApplicationRecord

  # associations
  has_many    :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_one     :transact, dependent: :destroy, class_name: 'Transact', inverse_of: :item
  accepts_nested_attributes_for :transact, update_only: true
  belongs_to  :category
  belongs_to  :sizing, optional: true
  delegate    :seller, :buyer, to: :transact
  has_many    :likes, dependent: :destroy

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
  validates :condition, presence: true
  validates :category_id, presence: true
  validate  :category_cannot_have_children, if: :category_id?
  validate  :presence_of_sizing_if_category_has_size, if: :category_id?
  validate  :sizing_has_to_be_child, if: :sizing_id?
  validate  :has_images

  # custom validate
  def category_cannot_have_children
    if category.has_children?
      errors.add(:category_id)
    end
  end

  def presence_of_sizing_if_category_has_size
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

  def has_images
    errors.add(:images, 'が投稿されていません') if images.size < 1
    errors.add(:imgaes, 'は10枚までです') if images.size > 10
  end

  # method
  def add_images(ids)
    ids = ids.split(',').map{ |id| id.to_i }
    ids.each do |id|
      images << Image.find(id)
    end
  end

  def add_category(category_params)
    unless category
      if category_params[:child_id].present?
        self.category = Category.find(category_params[:child_id])
      elsif category_params[:parent_id].present?
        self.category = Category.find(category_params[:parent_id])
      else
        self.category = nil
      end
    end
  end

#ユーザが商品に対していいねをすでに送っているかを判定するメソッドです。
  def liked_by?(user)
    likes.where(user_id:user.id).exists?
  end
#ユーザがした商品のidをとってくるメソッドです。
  def like_id(user)
    likes.where(user_id:user.id)
  end

end
