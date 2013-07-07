class CreateSplits < ActiveRecord::Migration
  def change
    create_table :splits do |t|
      t.integer :pm_id
      t.integer :transaction_id
      t.decimal :amount,            precision: 10, scale: 2
      t.decimal :xrate,            precision: 10, scale: 2
      t.integer :category_id
      t.integer :class_id
      t.text    :memo
      t.integer :transfer_to_account_id
      t.string  :currency_code
      t.string  :of_x_id

      t.timestamps
    end
  end
end
