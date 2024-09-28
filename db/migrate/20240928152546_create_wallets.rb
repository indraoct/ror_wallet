class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :users, null: false, foreign_key: true
      t.float :balance, null: false
      t.timestamps
    end
  end
end
