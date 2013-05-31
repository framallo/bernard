class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id
      t.timestamp :created_at
      t.integer :check_number
      t.integer :payee_id
      t.integer :category_id
      t.integer :department_id
      t.text    :memo
      t.decimal :amount
      t.boolean :cleared
      t.string :currency_id
      t.decimal :currency_exchange_rate, :precision => 10, :scale => 2
      t.decimal :balance, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
