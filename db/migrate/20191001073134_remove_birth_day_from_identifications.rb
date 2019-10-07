class RemoveBirthDayFromIdentifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :identifications, :Birth_day, :string
  end
end
