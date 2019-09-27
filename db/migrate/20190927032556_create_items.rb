class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer       :price,         null: false,        index: true
      t.string        :name,          null: false,        index: true
      t.references    :category,      foreign_key: true
      t.references    :sizing,        foreign_key: true
      t.string        :brand,                             index: true
      t.text          :description,   null: false
      t.integer       :condition,     null: false,        index: true

      t.timestamps
    end
  end
end
