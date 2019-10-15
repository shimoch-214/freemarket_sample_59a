class ChangePurchasedAtInTransact < ActiveRecord::Migration[5.2]
  def change
    rename_column :transacts, :purchased_at, :parchased_at
    change_column :transacts, :parchased_at, :datetime
  end
end
