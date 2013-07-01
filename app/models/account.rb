class Account < ActiveRecord::Base
  has_many :transactions

  def balance
    transactions.active.sum(:amount)
  end
end
