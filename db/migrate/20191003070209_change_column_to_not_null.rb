class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]

  def up
    change_column :adresses, :phone_number_sub,:string, null: true
  end

  def down
    change_column :adresses, :phone_number_sub,:string, null: false
  end
  
end
