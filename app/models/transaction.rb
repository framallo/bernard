class Transaction < ActiveRecord::Base
  require 'filter'
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
  scope :per_category, ->(id) {active.where(category_id: id).sum(:amount)}
                                 
  belongs_to :account   
  has_many :splits        
                            

  def split?
    @split ||= splits.size > 1
  end

  def category_name
    split? ? '<--Splits-->' : splits.first.category.try(:name)
  end

  PM_TYPES = [ 'Withdrawal', 'Deposit', 'Transfer', 'Other Transfer' ]

  def type_name
    PM_TYPES[pm_type]
  end

  def self.filter(conditions)
    Filter.new(conditions)
  end

end
