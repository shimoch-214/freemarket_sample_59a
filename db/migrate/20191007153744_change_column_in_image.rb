class ChangeColumnInImage < ActiveRecord::Migration[5.2]
  def change
    change_column_null :images, :item_id, true
  end
end
