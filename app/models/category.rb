class Category < ApplicationRecord
  has_ancestry
  has_many   :items
  belongs_to :sizing, optional: true
end