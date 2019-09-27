class ChangeColumnInCategories < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :size_id, :sizing_id
  end
end
