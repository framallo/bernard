class BudgetCategoryDecorator < Draper::Decorator
  delegate_all

  def dates_intervals(from, to)
    @@from = from
    @@to   = to+1
  end

  def amount
    amount = Category::BudgetCategory.interval(@@from, @@to)
    amount = amount.sum_category(model.id) 
    amount < 0 ? amount*-1 : amount
  end

  def limit
    (model.amount_day * ((@@to - @@from).to_i+1)).round(0)
  end

  def balance
    (limit - amount).round(0)
  end

  def available
    balance < 0 ? 0 : balance
  end

  def color 
    balance < 0 ? "danger" : "warning"
  end

  def spent_percentage
    percentage = (amount * 100) / limit
    percentage < 100 ? percentage : 100
  end

  def available_percentage
    100 - spent_percentage
  end

end
