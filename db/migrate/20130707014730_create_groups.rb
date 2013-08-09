class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.boolean  :deleted
      t.integer  :pm_id
      t.string   :name
      t.string   :uuid
      
      t.timestamps
    end
  end
end
