module BudgetsHelper
  def status(budget)
    total = total_category(budget) *-1 
    if total > budget_budgeted(budget)
      "danger"
    elsif total < budget_budgeted(budget)
      "success"
    else
      "warning"
    end
  end
  
  def total_category(budget)
    total = @filter.budgets_sum(budget.id) 
    total.round(2)
  end

  def budget_available(budget)
    available = budget_budgeted(budget) - total_category(budget)*-1 
    available = 0 if available < 0
    available.round(2)
  end

  def budget_balance(budget)
    balance = budget_budgeted(budget) - total_category(budget)*-1 
    balance.round(2)
  end

  def budget_budgeted(budget)
    case @filter.kind
    when "week"
       budget.budget_period == 1 ? budget.budget_limit : solve_budgeted_per_week(budget) 
    when "month"                                                              
       budget.budget_period == 2 ? budget.budget_limit : solve_budgeted_per_month(budget) 
    when "year"
       budget.budget_period == 4 ? budget.budget_limit : solve_budgeted_per_year(budget) 
    end
  end

  def solve_budgeted_per_week(budget)
    case budget.budget_period
    when 0
      (budget.budget_limit * 7).round(2)
    when 2
      weeks = Time::days_in_month(Time.now.month, Time.now.year).to_f / 7
      (budget.budget_limit / weeks).round(2)
    when 3
      # to do
    when 4
      (budget.budgeted_limit / 52).round(2) 
    end
  end

  def solve_budgeted_per_month(budget)
    case budget.budget_period
    when 0
      days =  Time::days_in_month(Time.now.month, Time.now.year)
      (budget.budget_limit * days).round(2)
    when 1
      weeks = Time::days_in_month(Time.now.month, Time.now.year).to_f / 7
      (budget.budget_limit * weeks).round(2)
    when 3
      # to do
    when 4
      (budget.budget_limit / 12).round(2)
    end
  end

  def solve_budgeted_per_year(budget)
    case budget.budget_period
    when 0
      (budget.budget_limit * 365).round(2)
    when 1
      (budget.budget_limit * 52).round(2)
    when 2
      (budget.budget_limit * 12).round(2)
    when 3
      # to do
    end
  end
  
  def set_period
    case @filter.kind
    when "month"
      @filter.from.strftime("%B")
    when "week"
      "#{@filter.from.strftime('%d %B %Y')} - #{@filter.to.strftime('%d %B %Y')}"
    when "year"
      @filter.from.year
    end
  end

end
