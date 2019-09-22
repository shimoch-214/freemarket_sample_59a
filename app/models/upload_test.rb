class UploadTest < ApplicationRecord
  mount_uploader :image, ImageUploader, if: :image?
end
