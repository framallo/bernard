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
      t = t.where('categories.id = ?', @conditions[:category_id]) if @conditions[:category_id]

      t
    end

    def categories
      return @categories if defined?(@categories)

      t = Category.joins(:splits => :transaction)
      t = t.select('categories.name', 'categories.id', 'count(transactions.amount) as count', 'sum(transactions.amount) as amount')
      t = t.group('categories.name', 'categories.id')
      t = t.joins(:splits => {:transaction => :account}).group('accounts.id').having(accounts: {id: @conditions[:account_id]} ) if @conditions[:account_id]

      @categories = t 
    end

    def categories_total
      categories.sum(&:amount)
    end

    def no_conditions?
      !@conditions.keys.include?(:account_id)
    end
      


    def url(condition)
    end
  end

end
