class AddNicknameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Nickname, :string,null: false
  end
end
