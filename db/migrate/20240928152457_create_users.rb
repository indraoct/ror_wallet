class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :password_digest # This column must be here
      t.string :salt
    end
  end
end
