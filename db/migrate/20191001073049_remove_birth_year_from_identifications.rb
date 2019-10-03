class RemoveBirthYearFromIdentifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :identifications, :Birth_year, :string
  end
end
