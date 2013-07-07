class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :pm_type
      t.integer :pm_id
      t.integer :account_id
      t.integer :pm_account_id
      t.text    :pm_payee
      t.decimal :pm_sub_total, :precision => 10, :scale => 2
      t.text    :pm_of_x_id
      t.binary  :pm_image
      t.text    :pm_overdraft_id

      t.datetime :date
      t.integer :account_id
      t.boolean :deleted
      t.text    :check_number
      t.text    :payee_name
      t.integer :payee_id
      t.integer :category_id
      t.integer :department_id
      t.decimal :amount
      t.boolean :cleared
      t.string    :uuid

      t.timestamps
    end
  end
end
