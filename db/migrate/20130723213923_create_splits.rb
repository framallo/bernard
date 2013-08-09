class CreateSplits < ActiveRecord::Migration
  def change
    create_table :splits do |t|
      t.integer   :pm_id
      t.integer   :transaction_id
      t.decimal   :amount
      t.decimal   :xrate,:precision => 10, :scale => 2
      t.integer   :category_id
      t.integer   :group_id
      t.string    :memo
      t.integer   :transfer_to_account_id
      t.string    :currency_code
      t.string    :ofxid

    end
  end
end
