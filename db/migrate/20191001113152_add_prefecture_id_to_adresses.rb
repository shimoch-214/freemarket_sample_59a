class AddPrefectureIdToAdresses < ActiveRecord::Migration[5.2]
  def change
    add_column :adresses, :prefecture_id, :integer
  end
end
