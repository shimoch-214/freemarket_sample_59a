class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string      :ancestry
      t.string      :name,        null:        false
      t.references  :size,     foreign_key: true

      t.timestamps
    end
  end
end
