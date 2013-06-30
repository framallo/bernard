class Transaction < ActiveRecord::Base
  scope :search, ->(q) { where "payee_name like ? OR amount = ? OR uuid = ?", "%#{q}%", q.to_i, q }
  belongs_to :account

  attr_accessor :balance
end
