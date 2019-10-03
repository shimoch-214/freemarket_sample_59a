class Sizing < ApplicationRecord
  has_ancestry
  has_many :categories
  has_many :items
end
