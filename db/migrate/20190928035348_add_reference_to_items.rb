class AddReferenceToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :transact, foreign_key: true, null: false, unique: true
  end
end
