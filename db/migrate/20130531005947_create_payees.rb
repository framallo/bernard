class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.string  :name
      t.boolean :deleted
      t.integer :pm_id
      t.float   :latitude
      t.float   :longitude
      t.string  :uuid

      t.timestamps
    end
  end
end
