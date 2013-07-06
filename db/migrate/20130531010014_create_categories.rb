class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |c|
      c.boolean                 :deleted                  
	    c.integer                 :timestamp				
	    c.integer                 :category_id			#	INTEGER PRIMARY KEY AUTOINCREMENT,
      c.string                  :name				    # TEXT UNIQUE,
      c.integer                 :pm_type				#	INTEGER  0=expenseType 1=incomeType
      c.integer                 :budget_period		# 0=day, 1=week, 2=month, 3=qtr, 4=year, 5=biweekly
      c.decimal                 :budget_limit, :precision => 10, :scale => 2 
      c.boolean                 :include_sub_categories  		
      c.boolean                 :rollover				
      c.string                  :uuid				

      c.timestamps
    end
  end
end
