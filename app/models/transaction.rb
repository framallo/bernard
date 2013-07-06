class Transaction < ActiveRecord::Base
  belongs_to :account

  attr_accessor :balance

  scope :deleted, -> { where(deleted: false) }
  scope :type5,   -> { where(pm_type: 5)}
end
