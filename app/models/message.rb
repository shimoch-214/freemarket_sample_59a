class Message < ApplicationRecord
  belongs_to :user
  belongs_to :transact

  validates :text, presence: true
end
