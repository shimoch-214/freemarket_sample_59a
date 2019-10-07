class CreateAdresses < ActiveRecord::Migration[5.2]
  def change
    create_table :adresses do |t|
      t.references :user, foreign_key:true,   null: false
      t.string     :first_name,               null: false
      t.string     :last_name,                null: false
      t.string     :first_name_kana,          null: false
      t.string     :last_name_kana,           null: false
      t.string     :zip_code,                 null: false
      t.string     :prefecture,               null: false
      t.string     :city,                     null: false
      t.string     :street,                   null: false
      t.string     :building,                 null: false
      t.string     :phone_number_sub,         null: false
      t.timestamps
    end
  end
end
