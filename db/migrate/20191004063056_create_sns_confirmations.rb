class CreateSnsConfirmations < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_confirmations do |t|
      t.references  :user, foreign_key: true
      t.string      :provider, null: false
      t.string      :uid, null: false
    end
  end
end
