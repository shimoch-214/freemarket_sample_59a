class RemoveBirthMonthFromIdentifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :identifications, :Birth_month, :string
  end
end
