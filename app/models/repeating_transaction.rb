class RepeatingTransaction < ActiveRecord::Base

  scope :active, ->     { where(deleted:false) }
end
