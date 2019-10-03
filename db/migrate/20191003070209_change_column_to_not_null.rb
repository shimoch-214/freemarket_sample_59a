class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :adresses, :phone_number_sub,:string, null: true
  end
end
