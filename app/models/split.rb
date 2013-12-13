class Split < ActiveRecord::Base

  belongs_to :transaction
  belongs_to :category
  belongs_to :department
  validates_associated :transaction, :category
end
