class AddAvatorImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avator_image, :string
  end
end
