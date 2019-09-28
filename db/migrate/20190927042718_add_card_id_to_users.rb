class AddCardIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Card_id, :integer
  end
end
