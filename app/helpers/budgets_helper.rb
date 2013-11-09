module BudgetsHelper
  def status(budget)
    total = total_category(budget) *-1 
    if total > budget.budget_limit
      "danger"
    elsif total < budget.budget_limit
      "success"
    else
      "warning"
    end
  end

  def total_category(budget)
    total = Split.per_category(budget.id).sum(:amount) 
    total
  end

  def budget_available(budget)
    available = budget.budget_limit - total_category(budget)*-1 
    available = 0 if available < 0
    available
  end

  def budget_balance(budget)
    available = budget.budget_limit - total_category(budget)*-1 
    available
  end
end
