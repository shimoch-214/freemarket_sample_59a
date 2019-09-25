class UploadTest < ApplicationRecord
  mount_uploader :image, ImageTestUploader, if: :image?
end
