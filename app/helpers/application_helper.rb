module ApplicationHelper

  def render_transactions transactions
    render partial: '/transactions/transactions', locals: {transactions: transactions} 
  end

  def cleared_icon(cleared)
    content_tag('i', '', class: cleared ? 'icon-ok' : 'icon-remove')
  end
end
