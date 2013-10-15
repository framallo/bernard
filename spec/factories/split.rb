require 'faker'

currency = ["AED", "ALL", "CAD", "CNY", "MXN", "IRR", "JPY", "USD", "UYU"]
transaction =  FactoryGirl.create(:transaction)
FactoryGirl.define do
  factory :split do
    pm_id                    transaction.pm_id
    transaction_id           transaction.id
    amount                   transaction.amount
    xrate                    (1..10).to_a.sample
    category_id              transaction.category_id
    class_id                 (0..10).to_a.sample
    memo                     Faker::Lorem.paragraph
    transfer_to_account_id   (1..100).to_a.sample
    currency_code            currency.sample
    x_of_id                  "dummy"
  end
end


