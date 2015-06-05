class Split < ActiveRecord::Base
  scope :with_amount, -> { where('amount<>0') }

  belongs_to :split_transaction, :foreign_key => 'transaction_id', :class_name => "Transaction"
  belongs_to :category
  belongs_to :department, foreign_key: "class_id"
  belongs_to :account, foreign_key: "transfer_to_account_id"

  validates_associated :transaction, :category

end
