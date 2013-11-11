class BudgetsController < ApplicationController
  def budgets 
    @filter = Split.filter(params) 
  end
end
