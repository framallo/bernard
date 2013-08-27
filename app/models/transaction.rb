class Transaction < ActiveRecord::Base
  # pm_types
  # 0 Withdrawal
  # 1 Deposit
  # 2 Transfer
  # 3 
  # 4
  # 5 Dunno but removed it for now
  #

  scope :search, ->(q) { where "payee_name like ? OR uuid = ?", "%#{q}%", q }
  scope :uuid, ->(uuid) { where(uuid:uuid).first }
  scope :active, ->     { where(deleted:false).where('transactions.pm_type <> 5') }
  scope :order_date, ->  { order('date desc') }
  scope :cleared, ->     { where(cleared:true) }
  scope :before_today, ->     { where('date < ?', Time.now) }
  scope :balance, -> { select('*').select('SUM(amount) OVER (PARTITION BY account_id ORDER BY date ASC) as balance') }
  scope :transaction_includes, -> { includes(:account,:splits => :category) }
  scope :full, -> { order_date.transaction_includes.active.balance }

  scope :interval, ->(from, to) { where("transactions.date >= ? AND transactions.date <= ?", from, to) }
  scope :total_amount, -> { select('count(transactions.amount) as total_count', 'sum(transactions.amount) as total_amount') }

  belongs_to :account
  has_many :splits


  def split?
    @split ||= splits.size > 1
  end

  def category_name
    split? ? '<--Splits-->' : splits.first.category.try(:name)
  end

  def self.filter(conditions)
    Filter.new(conditions)
  end

  class Filter

    def initialize(conditions)
      @conditions = conditions
      @category_ids = []
    end

    def accounts
      @accounts ||= Account.all
    end

    def transactions
      return @transactions if @transactions
      t = transaction_query.full

      @transactions = t
    end

    def categories
      return @categories if @categories

      t = Category.joins(:splits => :transaction)
      t = t.merge transaction_interval
      t = t.merge Transaction.total_amount
      t = t.select('categories.name', 'categories.id').group('categories.name', 'categories.id')
      t = t.joins(:splits => {:transaction => :account}).group('accounts.id').having(accounts: {id: account_id } ) if account_id

      @categories = t 
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

    private 

    def transaction_interval
      Transaction.interval(from, to)
    end

    def transaction_query
      t = transaction_interval
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
