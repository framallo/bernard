class Category < ActiveRecord::Base
  scope :active,             ->       { where(deleted:false) }
  scope :transaction_ids,    ->(ids)  { joins(:splits => :transaction).where(transactions: {id: ids})                        }
  scope :transaction_totals, ->       { joins(:splits => :transaction).merge(Transaction.total_amount)                       }
  scope :group_by_name,      ->       { select('categories.name', 'categories.id').group('categories.name', 'categories.id') }

  has_many :splits
end
