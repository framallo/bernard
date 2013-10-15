require 'faker'

boolean = [true, false]
currency = ["AED", "ALL", "CAD", "CNY", "MXN", "IRR", "JPY", "USD", "UYU"]
FactoryGirl.define do
  factory :account do
    deleted                       false
    pm_id                         Faker::Number.digit
    pm_account_type               Faker::Number.digit
    display_order                 Faker::Number.digit
    name                          Faker::Company.name
    balance_overall               Faker::Number.digit
    balance_cleared               Faker::Number.digit
    number                        Faker::Number.number(2)
    institution                   Faker::Company.suffix
    phone                         Faker::PhoneNumber.cell_phone
    expiration_date               Faker::Business.credit_card_expiry_date.strftime("%d%m%Y")
    check_number                  Faker::Number.digit
    notes                         Faker::Lorem.paragraph
    pm_icon                       "image"
    url                           Faker::Internet.url
    of_x_id                       "dummy"
    of_x_url                      Faker::Internet.domain_word
    password                      Faker::Internet.password
    fee                           Faker::Number.digit
    fixed_percent                 Faker::Number.digit
    limit_amount                  Faker::Number.digit
    limit                         boolean.sample
    total_worth                   boolean.sample
    exchange_rate                 Faker::Number.digit
    currency_code                 currency.sample
    last_sync_time                Time.now 
    routing_number                Faker::Number.digit
    overdraft_account_id          Faker::Number.digit
    keep_the_change_account_id    Faker::Number.digit
    heek_change_round_to          Faker::Number.digit
    uuid                          Faker::Code.isbn(64)
  end
end
