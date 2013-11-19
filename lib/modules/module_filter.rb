module FilterInterval
  class Filter

    def initialize(conditions)
      @conditions = conditions
      @category_ids = []
    end

    def accounts
      @accounts ||= Account.all
    end

    def transactions
      @transactions ||= transaction_query.full
    end

    def grouped_transactions
      case group_by
      when 'date'
        transactions.group_by {|t| t.date.to_s(:short_date) }
      when 'type'
        transactions.group_by {|t| t.type_name }
      when 'account'
        transactions.group_by {|t| t.account.name }
      when 'category'
        transactions.group_by {|t| t.category_name.to_s }
      end
    end

    def categories
      @categories ||= Category.transaction_totals.group_by_name.transaction_ids(transaction_ids)
    end

    def intervals
      [ Interval.new(:week), Interval.new(:month), Interval.new(:year) ]
    end

    def current_interval
      @conditions[:from] ?  Interval.new(kind,from)        : intervals.select {|i| i.kind.to_s == kind }.first
    end

    def from
      @conditions[:from] ?  Date.parse(@conditions[:from]) : current_interval.from
    end

    def to
      @conditions[:to] ?    Date.parse(@conditions[:to])   : current_interval.to
    end

    def kind
      @conditions[:kind] || 'month'
    end

    def previous
      @previous ||= current_interval.previous
    end

    def next
      @next ||= current_interval.next
    end

    def categories_total
      categories.to_a.sum(&:total_amount)
    end

    def types_total
      @types_total = widthdrawals_amount + deposits_amount + transfers_amount
    end

    def widthdrawals_amount
      types_query[0].to_f.abs
    end

    def deposits_amount
      types_query[1].to_f.abs
    end

    def transfers_amount
      types_query[2].to_f.abs
    end

    def widthdrawals_percentage
      (widthdrawals_amount/types_total * 100)
    end

    def deposits_percentage
      (deposits_amount / types_total * 100)
    end

    def transfers_percentage
      (transfers_amount / types_total * 100)
    end

    def transaction_ids
      @transaction_ids ||= transactions.map &:id
    end


    private 

    def types_query
      @types_query ||= Transaction.where(id: transaction_ids ).group('transactions.pm_type').sum(:amount)
    end

    def transaction_interval
      Transaction.interval(from, to)
    end

    def transaction_query
      t = transaction_interval
      t = t.where(pm_type: pm_type) if pm_type
      t = t.where(account_id: account_id) if account_id
      t = t.where('categories.id = ?', category_id) if category_id
      t
    end

    def account_id
      @conditions[:account_id]
    end

    def category_id
      @conditions[:category_id]
    end

    def pm_type
      @conditions[:pm_type]
    end

    def group_by
      @conditions[:group_by] || 'date'
    end

    class Interval
      attr_accessor :from, :to, :kind

      def initialize(kind, date = nil)
        @kind = kind
        @date = date
      end

      def from
        date.send("beginning_of_#{kind}")
      end

      def to
        date.send("end_of_#{kind}")
      end

      def date
        @date || Date.today
      end

      def to_hash
        { kind: kind,  from: from_string,  to: to_string  }
      end

      def from_string
        from.strftime('%Y%m%d')
      end

      def to_string
        to.strftime('%Y%m%d')
      end

      def name
        kind.to_s.humanize
      end

      def previous
        Interval.new(kind, from - 1.send(kind))
      end

      def next
        Interval.new(kind, from + 1.send(kind))
      end

    end
  end
end

