class Category < ApplicationRecord
  has_ancestry
  belongs_to :sizing
end
