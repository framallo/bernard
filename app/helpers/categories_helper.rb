module CategoriesHelper

  def total_budget
    Category::BudgetCategory.total_values(@filter.from, @filter.to+1.day)
  end
  
end
