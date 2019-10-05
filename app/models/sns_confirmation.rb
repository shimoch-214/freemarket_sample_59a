class SnsConfirmation < ApplicationRecord
  belongs_to  :user, optional: true

  validates :provider, presence: true, inclusion: { in: %w(facebook google_oauth2) }
  validates_uniqueness_of :uid, scope: :provider
  validates :email, presence: true

end
