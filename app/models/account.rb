class Account < ActiveRecord::Base
  # pm_type
  # 0 Checking
  # 1 Cash
  # 2 Credit Card
  # 3 Asset
  # 4 Liability
  # 5 Online
  # 6 Savings
  # 7 Money Market
  # 8 Credit Line
  #

  scope :active, ->     { where(deleted:false) }

  has_many :transactions


  PM_TYPES = ['Checking', 'Cash','Credit Card','Asset','Liability','Online','Savings','Money Market','Credit Line']

  def type_name
    PM_TYPES[pm_account_type]
  end


  def active_transactions
    transactions.transaction_includes.active.balance
  end

  def basic_balance
    active_transactions.active
  end

  def cleared_balance
    basic_balance.cleared.sum(:amount)
  end

  def current_balance
    basic_balance.before_today.sum(:amount)
  end

  def future_balance
    basic_balance.sum(:amount)
  end

  def available_credits
    0
  end

  def available_funds
    basic_balance.sum(:amount)
  end


end
