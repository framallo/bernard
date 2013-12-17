class Split < ActiveRecord::Base

  belongs_to :transaction
  belongs_to :category
  belongs_to :department, foreign_key: "class_id"

  validates_associated :transaction, :category

end
