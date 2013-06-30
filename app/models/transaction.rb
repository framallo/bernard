class Transaction < ActiveRecord::Base
  belongs_to :account

  attr_accessor :balance
end
