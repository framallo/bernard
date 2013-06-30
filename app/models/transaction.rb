class Transaction < ActiveRecord::Base
  default_scope { order(:date) }
  scope :search, ->(q) { where "payee_name like ? OR uuid = ?", "%#{q}%", q }
  scope :uuid, ->(uuid) { where(uuid:uuid).first }
  belongs_to :account

  attr_accessor :balance
end
