class BudgetsController < ApplicationController
  def budgets 
    @filter = Transaction.filter(params) 
  end
end
