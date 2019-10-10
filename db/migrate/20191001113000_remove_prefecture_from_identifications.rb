class RemovePrefectureFromIdentifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :identifications, :prefecture, :string
  end
end
