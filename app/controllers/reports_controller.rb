class ReportsController < ApplicationController

  def income_v_expense
    @report = Transaction.active.group(:pm_type).sum(:amount)#.income_v_expense
    format_respond
  end

  def spending_by_payee
    @report = Transaction.active.group(:payee_id).sum(:amount)
    format_respond
  end

  def net_worth
    @report = {}
    Transaction.net_worth.each do |e|
      @report[e.month] = e.amount.to_f
    end
    format_respond
  end          
               
  def spending_by_category
    @report = Transaction.active.group(:category_id).sum(:amount)
    format_respond
  end

  def format_respond
    respond_to do |format|
      format.html
      format.json { render json: json_for_chart }
    end
  end

  def json_for_chart

    {
      labels: @report.keys,
      datasets: [
        {
          fillColor: "rgba(220,220,220,0.5)",
          strokeColor: "rgba(220,220,220,1)",
          fillColor: "rgba(225, 0, 0, 0.5)",
          strokeColor: "rgba(220, 220, 220, 1)",
          data: @report.values
        }
      ]
    }
  end
end
