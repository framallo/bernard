class CategoriesController < ApplicationController
  def budgets
    @budgets = BudgetCategoriesDecorator.new(Category::BudgetCategory.all)
    @filter  = Category.filter(params)
  end
end
