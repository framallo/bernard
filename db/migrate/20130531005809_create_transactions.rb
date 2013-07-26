class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :pm_id
      t.boolean :deleted
      t.integer :pm_type
      t.datetime :date
      t.boolean :cleared
      t.integer :account_id
      t.string  :pm_payee
      t.string  :check_number
      t.decimal :amount, :precision => 10, :scale => 2
      t.string  :ofx_id
      t.string  :uuid
      t.string  :overdraft_id

      t.timestamps
    end
  end
end
