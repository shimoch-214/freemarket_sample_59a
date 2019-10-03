class AddPrefectureIdToIdentifications < ActiveRecord::Migration[5.2]
  def change
    add_column :identifications, :prefecture_id, :integer
  end
end
