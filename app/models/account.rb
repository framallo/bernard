class Account < ActiveRecord::Base
scope :active, -> { where(deleted: false)}
end
