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
    total.round(0)
  end

  def budget_available(budget)
    available = budget_budgeted(budget) - total_category(budget)*-1 
    available = 0 if available < 0
    available.round(0)
  end

  def budget_balance(budget)
    balance = budget_budgeted(budget) - total_category(budget)*-1 
    balance.round(0)
  end

  def available_percentage(budget)
    unless status(budget) == "danger" or status(budget) == "warning"
      percentage = (budget_available(budget) * 100 / budget_budgeted(budget))
      percentage = 100 if percentage > 100
      percentage
    else
      100
    end
  end

  def spent_percentage(budget) 
    unless status(budget) == "danger" or status(budget) == "warning"
      ((total_category(budget)*-1) * 100 / budget_budgeted(budget))
    else
      0
    end
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
      (budget.budget_limit * 7).round(0)
    when 2
      weeks = Time::days_in_month(@filter.from.month, @filter.from.year).to_f / 7
      (budget.budget_limit / weeks).round(0)
    when 3
      # to do
    when 4
      (budget.budgeted_limit / 52.142857143).round(0) 
    end
  end

  def solve_budgeted_per_month(budget)
    case budget.budget_period
    when 0
      days =  Time::days_in_month(@filter.from.month, @filter.from.year)
      (budget.budget_limit * days).round(0)
    when 1
      weeks = Time::days_in_month(@filter.from.month, @filter.from.year).to_f / 7
      (budget.budget_limit * weeks).round(0)
    when 3
      # to do
    when 4
      (budget.budget_limit / 12).round(0)
    end
  end

  def solve_budgeted_per_year(budget)
    case budget.budget_period
    when 0
      (budget.budget_limit * 365).round(0)
    when 1
      (budget.budget_limit * 52.142857143).round(0)
    when 2
      (budget.budget_limit * 12).round(0)
    when 3
      # to do
    end
  end
  
  def set_period
    case @filter.kind
    when "month"
      @filter.from.strftime("%B %Y")
    when "week"
      "#{@filter.from.strftime('%d %B %Y')} - #{@filter.to.strftime('%d %B %Y')}"
    when "year"
      @filter.from.year
    end
  end

end
