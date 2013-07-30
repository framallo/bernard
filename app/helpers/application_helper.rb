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

  def money(amount)
    content_tag :span, class: amount > 0 ? 'amount-positive' : 'amount-negative' do
      number_to_currency amount
    end
  end

  def filter_item(param, value_true, &block)
    content_tag :li, :class=> params[param] == value_true ? 'active' : '', &block
  end

end
