class Category < ActiveRecord::Base
  scope :active, ->     { where(deleted:false) }
  has_many :splits
end
