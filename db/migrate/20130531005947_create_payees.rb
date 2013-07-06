class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.boolean       :deleted
      t.integer     	:timestamp      #		INTEGER,
      t.integer     	:pm_id          #		INTEGER PRIMARY KEY AUTOINCREMENT,
      t.string      	:name           #		TEXT UNIQUE,
      t.string      	:latitude
      t.string        :longitude
      t.string       	:uuid

      t.timestamps
    end
    add_index(:payees, [:name], unique: true)
  end
end

