class ReportsController < ApplicationController

  def income_v_expense
    @report = Transaction.all.group(:pm_type).sum(:amount)
    respond_to do |format|
      format.html
      format.json { render json: income_v_expense_json }
    end
  end

  def spending_by_payee
    @report = Transaction.all.group(:payee_id).sum(:amount)
    respond_to do |format|
      format.html
      format.json { render json: spending_by_payee_json }
    end
  end

  def net_worth
    @report = {}
    Transaction.net_worth.each do |e|
      @report[e.month] = e.amount.to_f
    end
    respond_to do |format|
      format.html
      format.json { render json: net_worth_json }
    end
  end          
               
  def spending_by_category
    @report = Transaction.all.group(:category_id).sum(:amount)
    respond_to do |format|
      format.html
      format.json { render json: spending_by_category_json }
    end
  end

  def income_v_expense_json
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

  def spending_by_payee_json
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

  def spending_by_category_json
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

  def net_worth_json 
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
