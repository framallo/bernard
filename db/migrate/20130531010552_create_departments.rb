class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :pm_id
      t.string  :uuid
      t.boolean :deleted

      t.timestamps
    end
  end
end
