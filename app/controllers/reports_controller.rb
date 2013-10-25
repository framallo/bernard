class ReportsController < ApplicationController

  def income_v_expense
    @report = Transaction.all.group(:pm_type).sum(:amount)
  end

  def spending_by_payee
  end

  def net_worth
    @report = Transaction.where("account_id = 1 and date between '2013-01-01' and '2014-01-01'").sum(:amount).to_f
  end

  def spending_by_category
  end

end
