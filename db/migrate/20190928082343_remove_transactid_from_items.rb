class RemoveTransactidFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :items, :transacts
    remove_reference :items, :transact
  end
end
