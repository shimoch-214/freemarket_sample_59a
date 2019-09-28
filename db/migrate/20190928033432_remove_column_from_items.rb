class RemoveColumnFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :items, :transactions
    remove_reference :items, :transaction
  end
end
