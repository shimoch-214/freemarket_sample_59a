class RenameUserColumnToIdentifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :identifications, :user,:user_id
  end
end
