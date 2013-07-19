class CreateRepeatingTransactions < ActiveRecord::Migration
  def change
    create_table :repeating_transactions do |t|
      t.boolean  :deleted
      t.datetime :last_processed_date
      t.integer  :transaction_id
      t.integer  :pm_type
      t.integer  :end_date
      t.integer  :frequency
      t.integer  :repeat_on
      t.integer  :start_of_week
      t.integer  :send_local_notification
      t.integer  :notify_days_in_advance
      t.string   :uuid
      t.timestamps
    end
  end
end
