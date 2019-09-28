class RenameTransactionsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :transactions, :transacts
  end
end
