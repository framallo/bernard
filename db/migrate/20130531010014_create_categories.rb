class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |c|
      c.boolean                 :deleted
      c.integer                 :timestamp
      c.integer                 :category_id
      c.string                  :name
      c.integer                 :pm_type
      c.integer                 :budget_period
      c.decimal                 :budget_limit, :precision => 10, :scale => 2
      c.boolean                 :include_sub_categories
      c.boolean                 :rollover
      c.string                  :uuid

      c.timestamps
    end
  end
end
