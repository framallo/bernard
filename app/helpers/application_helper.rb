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

  def progress_bar(type, percentage, &block)
    content_tag :div, :class=> "bar bar-#{type}", :style=>"width:#{percentage}%;", &block if percentage > 0
  end

  def set_period(filter)
    case filter.kind
    when "month"
      filter.from.strftime("%B %Y")
    when "week"
      "#{filter.from.strftime('%d %B %Y')} - #{filter.to.strftime('%d %B %Y')}"
    when "year"
      filter.from.year
    end
  end

end
