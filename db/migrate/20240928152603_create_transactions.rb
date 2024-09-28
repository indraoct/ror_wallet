class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users } # Custom field name
      t.references :receiver, null: false, foreign_key: { to_table: :users } # Custom field name
      t.string :description
      t.timestamps
    end
  end
end
