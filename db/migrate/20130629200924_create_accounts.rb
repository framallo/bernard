class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|

      t.boolean  :deleted
      t.datetime :updated_at
      t.integer  :pm_account_id
      t.integer  :pm_account_type
      t.integer  :display_order
      t.string   :name
      t.decimal  :balance_overall            ,  :precision => 10 ,  :scale => 2
      t.decimal  :balance_cleared            ,  :precision => 10 ,  :scale => 2
      t.string   :number
      t.string   :institution
      t.string   :phone
      t.string   :expiration_date
      t.string   :check_number
      t.text     :notes
      t.string   :pm_icon
      t.string   :url
      t.string   :of_x_id
      t.string   :of_x_url
      t.string   :password
      t.decimal  :fee                        ,  :precision => 10 ,  :scale => 2
      t.decimal  :fixed_percent              ,  :precision => 10 ,  :scale => 2
      t.decimal  :limit_amount               ,  :precision => 10 ,  :scale => 2
      t.boolean  :limit
      t.boolean  :total_worth
      t.decimal  :exchange_rate              ,  :precision => 10 ,  :scale => 2
      t.string   :currency_code
      t.datetime :last_sync_time
      t.string   :routing_number
      t.string   :overdraft_account_id
      t.string   :keep_the_change_account_id
      t.decimal  :heek_change_round_to       ,  :precision => 10 ,  :scale => 2
      t.string   :uuid

      t.timestamps
    end
  end
end
