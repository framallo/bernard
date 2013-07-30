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
      t = Transaction.full
      t = t.where(account_id: @conditions[:account_id]) if @conditions[:account_id]
      t = t.where("date >= ? AND date <= ?", from_date, to_date )
      t = t.where('categories.id = ?', @conditions[:category_id]) if @conditions[:category_id]

      t
    end

    def categories
      return @categories if defined?(@categories)

      t = Category.joins(:splits => :transaction)
      t = t.select('categories.name', 'categories.id', 'count(transactions.amount) as count', 'sum(transactions.amount) as amount')
      t = t.where("date >= ? AND date <= ?", from_date, to_date )
      t = t.group('categories.name', 'categories.id')
      t = t.joins(:splits => {:transaction => :account}).group('accounts.id').having(accounts: {id: account_id } ) if account_id

      @categories = t 
    end

    def categories_total
      categories.sum(&:amount)
    end

    def no_conditions?
      !@conditions.keys.include?(:account_id)
    end

    def intervals
      {
        'week' =>  { kind: 'week',  from: date_to_s(beginning_of_week),  to: date_to_s(end_of_week)  },
        'month' => { kind: 'month', from: date_to_s(beginning_of_month), to: date_to_s(end_of_month) },
        'year' =>  { kind: 'year',  from: date_to_s(beginning_of_year),  to: date_to_s(end_of_year)  }
      }

    end

    def beginning_of_year
      Date.today.beginning_of_year
    end

    def end_of_year
      Date.today.end_of_year
    end

    def beginning_of_month
      Date.today.beginning_of_month
    end

    def end_of_month
      Date.today.end_of_month
    end

    def beginning_of_week
      Date.today.beginning_of_week
    end

    def end_of_week
      Date.today.end_of_week
    end

    def date_to_s(date)
      date.strftime('%Y%m%d')
    end

    def from
      @conditions[:from] || intervals[kind][:from]
    end

    def to
      @conditions[:to]   || intervals[kind][:to]
    end

    def from_date
      Date.parse(from)
    end

    def to_date
      Date.parse(to)
    end

    def kind
      @conditions[:kind] || 'month'
    end

    def account_id
      @conditions[:account_id]
    end

  end

end
