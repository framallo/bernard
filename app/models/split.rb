class Split < ActiveRecord::Base

  belongs_to :transaction
  belongs_to :category

  validates_associated :transaction, :category
  scope :active, -> {Split.where({id: transaction_active_ids})}
  scope :per_category, ->(id) {active.where(category_id: id)}

  def self.transaction_active_ids
    Transaction.active.map(&:id)
  end
end
