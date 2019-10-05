class AddColumnsToSnsConfirmations < ActiveRecord::Migration[5.2]
  def change
    add_column  :sns_confirmations, :email, :string
    add_index   :sns_confirmations, [:provider, :uid], unique: true
  end
end
