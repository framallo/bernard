require 'faker'

boolean = [true, false]
currency = ["AED", "ALL", "CAD", "CNY", "MXN", "IRR", "JPY", "USD", "UYU"]
FactoryGirl.define do
  factory :account do
    deleted                       false
    pm_id                         (0..2).to_a.sample
    pm_account_type               (0..8).to_a.sample
    display_order                 (1..9).to_a.sample
    name                          Faker::Company.name
    balance_overall               (1..9).to_a.sample
    balance_cleared               (1..9).to_a.sample
    number                        Faker::Number.number(2)
    institution                   Faker::Company.suffix
    phone                         Faker::PhoneNumber.cell_phone
    expiration_date               Faker::Business.credit_card_expiry_date.strftime("%d%m%Y")
    check_number                  (1..9).to_a.sample
    notes                         Faker::Lorem.paragraph
    pm_icon                       "image"
    url                           Faker::Internet.url
    of_x_id                       "dummy"
    of_x_url                      Faker::Internet.domain_word
    password                      Faker::Internet.password
    fee                           (1..9).to_a.sample
    fixed_percent                 (1..9).to_a.sample
    limit_amount                  (1..9).to_a.sample
    limit                         boolean.sample
    total_worth                   boolean.sample
    exchange_rate                 (1..9).to_a.sample
    currency_code                 currency.sample
    last_sync_time                Time.now 
    routing_number                (1..9).to_a.sample
    overdraft_account_id          (1..9).to_a.sample
    keep_the_change_account_id    (1..9).to_a.sample
    heek_change_round_to          (1..9).to_a.sample
    uuid                          Faker::Code.isbn(64)
  end
end
