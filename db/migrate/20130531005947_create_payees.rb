class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.string :name

      t.timestamps
    end
  end
end
