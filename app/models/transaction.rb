class Transaction < ActiveRecord::Base
  belongs_to :account
  has_many :splits
  has_many :categories, :through => :splits

  attr_accessor :balance

  scope :active,  -> { where.not(deleted: true, pm_type: 5, account_id: 0)}
  scope :everything,  -> { includes(:account, :categories) }
  scope :full,  -> { active.everything}


  def category_names
    categories.map {|c| c.name }.join(",")
  end

end
