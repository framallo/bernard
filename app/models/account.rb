class Account < ActiveRecord::Base
  scope :deleted, -> { where(deleted: false) }
end
