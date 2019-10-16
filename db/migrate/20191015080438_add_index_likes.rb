class AddIndexLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, [:item_id, :user_id], unique: true
  end
end
