class ReportsController < ApplicationController

  def index
  end

  def net_worth
  end

  def income_v_expense
    @report = Transaction.all.group(:pm_type).sum(:amount) 
  end

  def spending_by_payee
  end

  def spending_by_category
  end
end
