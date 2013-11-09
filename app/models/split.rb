class Split < ActiveRecord::Base

  belongs_to :transaction
  belongs_to :category

  validates_associated :transaction, :category
  scope :per_category, ->(id) {where(category_id: id)}
end
