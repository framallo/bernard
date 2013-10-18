class ReportsController < ApplicationController

  def index
  end

  def net_worth
  end

  def income_v_expense
    @report = Transaction.all.group(:pm_type).sum(:amount) 

    respond_to do |format|
      format.html
      format.json { render json: income_v_expense_json }
    end
  end

  def income_v_expense_json
    {
      labels: @report.keys,
      datasets: [
        {
          fillColor: "rgba(220,220,220,0.5)",
          strokeColor: "rgba(220,220,220,1)",
          data: @report.values
        }
      ]

    }
  end

  def spending_by_payee
  end

  def spending_by_category
  end
end
