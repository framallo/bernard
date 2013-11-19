class CategoriesController < ApplicationController
  def budgets
    @budgets = Category::BudgetCategory.all
    @filter  = Category.filter(params)
  end
end
