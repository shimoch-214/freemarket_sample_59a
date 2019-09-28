class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references  :item,      foreign_key: true,      null: false
      t.references  :seller,                            null: false
      t.references  :buyer
      t.integer     :delivery_method,                   null: false
      t.boolean     :bearing,                           null: false
      t.integer     :ship_days,                         null: false
      t.integer     :status,                            null: false,    default: 0
      t.integer     :prefecture_id,                     null: false
      t.date        :purchased_at

      t.timestamps
    end
    add_foreign_key :transactions,  :users, column: :seller_id
    add_foreign_key :transactions,  :users, column: :buyer_id
  end
end
