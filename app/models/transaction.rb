class Transaction < ActiveRecord::Base
  belongs_to :account

  attr_accessor :balance

  scope :active, -> { where.not(deleted: true, pm_type: 5, account_id: 0) }
  scope :type5,   -> { where(pm_type: 5)}

end
