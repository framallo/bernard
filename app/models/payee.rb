class Payee < ActiveRecord::Base

  scope :active, ->     { where(deleted:false) }
end
