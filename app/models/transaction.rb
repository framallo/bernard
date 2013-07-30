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
      t = Transaction.full.interval(from, to)
      t = t.where(account_id: @conditions[:account_id]) if @conditions[:account_id]
      t = t.where('categories.id = ?', @conditions[:category_id]) if @conditions[:category_id]

      t
    end

    def categories
      return @categories if defined?(@categories)

      t = Category.joins(:splits => :transaction)
      t = t.merge Transaction.active.interval(from, to)
      t = t.merge Transaction.total_amount
      t = t.select('categories.name', 'categories.id').group('categories.name', 'categories.id')
      t = t.joins(:splits => {:transaction => :account}).group('accounts.id').having(accounts: {id: account_id } ) if account_id

      @categories = t 
    end

    def categories_total
      categories.to_a.sum(&:total_amount)
    end

    def no_conditions?
      !@conditions.keys.include?(:account_id)
    end

    def intervals
      [ Interval.new(:week), Interval.new(:month), Interval.new(:year) ]
    end

    def current_interval
      intervals.select {|i| i.kind.to_s == kind }.first
    end

    def from
      @conditions[:from] ? Date.parse(@conditions[:from]) : current_interval.from
    end

    def to
      @conditions[:to] ? Date.parse(@conditions[:to]) : current_interval.to
    end

    def kind
      @conditions[:kind] || 'month'
    end

    def account_id
      @conditions[:account_id]
    end

    class Interval
      attr_accessor :from, :to, :kind

      def initialize(kind)
        @kind = kind
      end

      def from
        today.send("beginning_of_#{kind}")
      end

      def to
        today.send("end_of_#{kind}")
      end

      def today
        Date.today
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

    end

  end

end
