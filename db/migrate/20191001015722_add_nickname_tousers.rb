class AddNicknameTousers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false
  end
end
