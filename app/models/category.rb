require 'filter'
class Category < ActiveRecord::Base
  class BudgetCategory < ActiveRecord::Base
    self.table_name = "budget_categories"
    self.primary_key = "id"
    belongs_to :category, foreign_key: "id"
    scope :incomes, -> { budgets.where(budget_type: 1)}
    scope :expenses, -> { budgets.where(budget_type: 0)}
    scope :sum_incomes,  -> { where(budget_type: 1).sum(:amount) }
    scope :sum_expenses, -> { where(budget_type: 0).sum(:amount) }
    scope :interval, ->(from, to) { where("budget_categories.date >= ? AND budget_categories.date <= ?", from, to) }
    scope :budgets,      -> {select("id, amount_day, budget_type, name").order("name").uniq}
    scope :sum_category, ->(id) { where(id: id).sum(:amount) }
   
    def self.total_values(from, to)
      @@days = (to - from).to_i
      @@interval = interval(from, to)
      @@spent = total_spent * -1
      @@entries = total_entries
      Hash['saved', saved, 'beat', beat_budget, 'missing', missing_budget, 'deficit', deficit ]
    end

    private
    def self.total_spent
      @@interval.sum_expenses
    end

    def self.total_entries
      @@interval.sum_incomes
    end
    
    def self.saved 
      @@entries > @@spent ? @@entries - @@spent : 0
    end

    def self.beat_budget
      value = income_vs_expense
      value > 0 ? value : 0
    end

    def self.missing_budget
      value = income_vs_expense
      value < 0 ? value : 0
    end

    def self.deficit
      @@entries - @@spent > 0 ? 0 : @@entries - @@spent
    end
 
    def self.income_vs_expense
      incomes = @@entries - budget_entries 
      expenses = budget_expenses - @@spent
      incomes + expenses
    end

    def self.budget_entries
      ((incomes.map(&:amount_day).sum) * @@days).round(0) 
    end

    def self.budget_expenses
      ((expenses.map(&:amount_day).sum) * @@days).round(0) 
    end
  end

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
  scope :income_sum,         ->       { income.sum(:budget_limit) }
  has_many :splits
  has_one :budget_category, foreign_key: "id"

  def self.filter(params)
    Filter.new(params)
  end
  

end
