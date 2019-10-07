class RemoveUserIdToIdentifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :identifications, :user_id, :string
  end
end
