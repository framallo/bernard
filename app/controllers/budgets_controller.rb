class BudgetsController < ApplicationController
  def budgets 
    @budgets = Category.budgeted 
  end
end
