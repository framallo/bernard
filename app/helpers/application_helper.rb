module ApplicationHelper

  # available options:
  # * show_balance boolean
  def render_transactions transactions, o = {}
    default_options = {show_balance: true}
    options = default_options.merge(o)

    render partial: '/transactions/transactions', locals: options.merge(options: options, transactions: transactions)
  end

  def cleared_icon(cleared)
    content_tag('i', '', class: cleared ? 'icon-ok' : 'icon-remove')
  end
end
