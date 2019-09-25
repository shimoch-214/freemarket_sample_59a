class CreateUploadTests < ActiveRecord::Migration[5.2]
  def change
    create_table :upload_tests do |t|
      t.string :image
      t.timestamps
    end
  end
end
