class CreateIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :identifications do |t|
      # t.references :user, foreign_key: true, null: false
      t.string :user, foreign_key: true,      null: false
      t.string :first_name,                   null: false
      t.string :last_name,                    null: false
      t.string :first_name_kana,              null: false
      t.string :last_name_kana,               null: false
      t.string :zip_code             
      t.string :prefecture            
      t.string :city                   
      t.string :street                 
      t.string :building              
      t.string :birth_year,                  null: false
      t.string :birth_month,                 null: false
      t.string :birth_day,                   null: false
      t.timestamps
    end
  end
end
