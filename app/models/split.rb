class Split < ActiveRecord::Base

  belongs_to :transaction
  belongs_to :category

  validates_associated :transaction, :category


end
