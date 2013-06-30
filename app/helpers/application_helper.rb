module ApplicationHelper

  def render_transactions transactions
    render partial: '/transactions/transactions', locals: {transactions: transactions} 
  end
end
