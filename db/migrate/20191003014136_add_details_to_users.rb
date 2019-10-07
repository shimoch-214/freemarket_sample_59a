class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avator_image, :string
    add_column :users, :profile, :text
    add_column :users, :card_id, :integer
  end
end
