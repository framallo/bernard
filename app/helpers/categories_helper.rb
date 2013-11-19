module CategoriesHelper
  def values(budget)
    amount     = amount(budget.id)
    limit      = limit(budget.amount_day)
    balance    = balance(limit, amount)
    available  = available(balance)
    color      = color(balance)
    spent_percentage     = spent_percentage(amount, limit)
    available_percentage = available_percentage(spent_percentage)
    Hash['amount', amount, 'limit', 
         limit, 'balance', balance, 
         'available', available,
         'spent_percentage', spent_percentage,
         'color', color,
         'available_percentage', available_percentage]
  end

  def amount(id)
    amount = Category::BudgetCategory.interval(@filter.from, @filter.to+1)
    amount = amount.sum_category(id)
    amount < 0 ? amount*-1 : amount
  end

  def limit(limit)
    (limit * ((@filter.to - @filter.from).to_i+1)).round(0)
  end

  def available(balance)
    balance < 0 ? 0 : balance
  end
  
  def balance(limit, amount)
    (limit - amount).round(0)
  end

  def color(balance) 
    balance < 0 ? "danger" : "warning"
  end
  
  def spent_percentage(amount, limit)
    percentage = (amount * 100) / limit
    percentage < 100 ? percentage : 100
  end

  def available_percentage(spent)
    100 - spent
  end


  def total_budget
    Category::BudgetCategory.total_values(@filter.from, @filter.to+1.day)
  end
  
end
