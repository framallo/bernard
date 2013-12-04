class CategoriesController < ApplicationController
  def budgets
    @budgets = BudgetCategoryDecorator.new(Category::BudgetCategory.all)
    @filter  = Category.filter(params)
  end
end
