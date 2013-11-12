class Category < ActiveRecord::Base
  ## Budget period
  # 0 diario
  # 1 Semanal
  # 2 Mensual
  # 3 Cuatrimestral
  # 4 Anual
  scope :active,             ->       { where(deleted:false) }
  scope :transaction_ids,    ->(ids)  { joins(:splits => :transaction).where(transactions: {id: ids})                        }
  scope :transaction_totals, ->       { joins(:splits => :transaction).merge(Transaction.total_amount)                       }
  scope :group_by_name,      ->       { select('categories.name', 'categories.id').group('categories.name', 'categories.id') }
  scope :budgeted,           ->       { active.where("budget_limit is not null and budget_period is not null ") }

  has_many :splits
end
