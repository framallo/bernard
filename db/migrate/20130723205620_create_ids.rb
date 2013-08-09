class CreateIds < ActiveRecord::Migration
  def change
    create_table  :ids do |t|
      t.boolean   :deleted
      t.integer   :id_id
      t.string    :pm_id
      t.string    :uuid
      t.timestamps
    end
  end
end
