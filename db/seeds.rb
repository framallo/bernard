boolean = [true]  #To have inactive transactions, add false at array [true, false]
currency = ["AED", "ALL", "CAD", "CNY", "MXN", "IRR", "JPY", "USD", "UYU"]
#Seed to Account table
5.times do
  Account.create(
    deleted: false,
    pm_id: rand(0..8),
    pm_account_type: rand(0..8),
    display_order: rand(1..4),
    name: Faker::Company.name,
    balance_overall: rand*(5),
    balance_cleared: rand*(5),
    number: Faker::Number.number(2),
    institution: Faker::Company.suffix,
    phone: Faker::PhoneNumber.cell_phone,
    expiration_date: Faker::Business.credit_card_expiry_date.strftime("%d,%m,%Y"),
    check_number: Faker::Number.digit,
    notes: Faker::Lorem.paragraph,
    pm_icon: "image",
    url: Faker::Internet.url,
    of_x_id: "dummy",
    of_x_url: Faker::Internet.domain_word,
    password: Faker::Internet.password,
    fee: rand*(100),
    fixed_percent: rand*(20),
    limit_amount: 1000 + rand*(9_000),
    limit: boolean.sample,
    total_worth: boolean.sample,
    exchange_rate: rand*(10),
    currency_code: currency.sample,
    last_sync_time: (Time.now - rand(60).days).to_date,
    routing_number: rand(100),
    overdraft_account_id: rand(30).to_s,
    keep_the_change_account_id: rand(30).to_s,
    heek_change_round_to: rand*(5),
    uuid: Faker::Code.isbn(64)
  )
  #seed to category table
  Category.create(
    name: Faker::Commerce.department, 
    deleted: boolean.sample,
    pm_id: rand(0..8),
    pm_type: rand(0..2),
    budget_period: rand(100..10000),
    budget_limit: rand(500..5000),
    include_subcategories: boolean.sample,
    rollover: boolean.sample,
    uuid: Faker::Code.isbn
  )
  #seed to department table
  Department.create(
    name: Faker::Commerce.product_name,
    pm_id: rand(0..8),
    uuid: Faker::Code.isbn,
    deleted: boolean.sample
  )
  #seed to Payee table
  Payee.create(
    name: Faker::Name.name,
    deleted: boolean.sample,
    pm_id: rand(0..8),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    uuid: Faker::Code.isbn
  )
end

account_all = Account.all.map(&:id)
payee_all = Payee.all.map(&:id) 

10.times do

  account = account_all.sample
  amount = 10 + rand*(10_000)
  payee = payee_all.sample

  #seed to transaction table
  Transaction.create(
    pm_type: rand(0..2),
    pm_id: rand(0..8),
    account_id: account,
    pm_account_id: account,
    pm_payee: Payee.find(payee).name,
    pm_sub_total: rand*(1_000),
    pm_of_x_id: "dummy",
    pm_image: "dummy",
    pm_overdraft_id: rand(30).to_s,
    date: Time.now - rand(0..60).days,
    deleted: boolean.sample,
    check_number: rand(10).to_s,
    payee_name: Payee.find(payee).name,
    payee_id: payee,
    category_id: Category.all.map(&:id).sample,
    department_id: Department.all.map(&:id).sample,
    amount: amount,
    cleared: boolean.sample,
    uuid: Faker::Code.isbn
  )
  #create split to transaction
  transaction = Transaction.last 
  num_of_split = rand(1..5)
  max_amount_split = amount/(num_of_split - 1)
  sum_split_amount = 0
  (num_of_split - 1).times do
    split_amount = 1 + rand(max_amount_split)
    sum_split_amount += split_amount
    Split.create(
      pm_id: transaction.pm_id,
      transaction_id: transaction.id,
      amount: split_amount,
      xrate: rand*(5),
      category_id: transaction.category_id,
      class_id: rand(0..10),
      memo: Faker::Lorem.paragraph,
      transfer_to_account_id: rand(100),
      currency_code: currency.sample,
      of_x_id: "dummy"
    )
  end  
  last_split_amount = amount - sum_split_amount
  Split.create(
    pm_id: transaction.pm_id,
    transaction_id: transaction.id,
    amount: last_split_amount,
    xrate: rand*(5),
    category_id: transaction.category_id,
    class_id: rand(0..10),
    memo: Faker::Lorem.paragraph,
    transfer_to_account_id: rand(100),
    currency_code: currency.sample,
    of_x_id: "dummy"
  )

end


