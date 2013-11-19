class CreateBudgetCategories < ActiveRecord::Migration
  def change
    execute <<-SQL
    CREATE VIEW budget_categories AS
      select name,c.id as id, t.id as transaction_id, 
      c.budget_limit as limit, c.budget_period as period, t.date,
      c.pm_type as budget_type, t.amount, case 
      when budget_period = 1 then budget_limit/7
      when budget_period = 2 then budget_limit/30
      when budget_period = 4 then budget_limit/365
      end as amount_day,
      (select sum(amount) from transactions t where t.category_id = c.id 
      and t.deleted = 'false' and t.pm_type <> 5) as category_amount
      from categories c
      inner join transactions t on t.category_id = c.id and t.deleted = false and t.pm_type <> 5
      WHERE c.budget_limit is not null and c.deleted = 'false' 
      order by c.name
    SQL
  end
end
