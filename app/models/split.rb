class Split < ActiveRecord::Base
  require 'filter'

  belongs_to :transaction
  belongs_to :category

  validates_associated :transaction, :category

  scope :active, -> {Split.where({id: transaction_active_ids})}
  scope :per_category, ->(id) {active.where(category_id: id)}
  scope :interval, ->(from, to) { where("splits.date >= ? AND splits.date <= ?", from, to) }

  def self.transaction_active_ids
    Transaction.active.map(&:id)
  end

  def self.filter(conditions)
    Filter.new(conditions)
  end

end
