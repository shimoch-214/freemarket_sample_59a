class ChangeColumnToAdresses < ActiveRecord::Migration[5.2]
  def change
    change_column :adresses, :prefecture_id, :integer, null: false
  end
end
