class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :deleted
      t.integer :pm_id
      t.integer :pm_type
      t.integer :budget_period
      t.decimal :budget_limit
      t.boolean :include_subcategories
      t.boolean :rollover
      t.string  :uuid

      t.timestamps
    end
  end
end
