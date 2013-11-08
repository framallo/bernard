class Category < ActiveRecord::Base
  ## Budget period
  # 1 Semanal
  # 2 Mensual
  scope :active,             ->       { where(deleted:false) }
  scope :transaction_ids,    ->(ids)  { joins(:splits => :transaction).where(transactions: {id: ids})                        }
  scope :transaction_totals, ->       { joins(:splits => :transaction).merge(Transaction.total_amount)                       }
  scope :group_by_name,      ->       { select('categories.name', 'categories.id').group('categories.name', 'categories.id') }
  scope :budgeted,           ->       { where("budget_limit is not null and budget_period is not null ") }

  has_many :splits
end
