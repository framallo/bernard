require 'faker'

account = FactoryGirl.create(:account)
payee = FactoryGirl.create(:payee)
department = FactoryGirl.create(:department)
category = FactoryGirl.create(:category)

FactoryGirl.define do
  factory :transaction do
    pm_type           (0..2).to_a.sample
    pm_id             (0..8).to_a.sample
    account_id        account.id
    pm_account_id     account.id
    pm_payee          payee.name
    pm_sub_total      (10..10_000).to_a.sample 
    pm_of_x_id        "dummy"
    pm_image          "dummy"
    pm_overdraft_id   (1..30).to_a.sample.to_s
    date              Time.now
    deleted           false
    check_number      (1..10).to_a.sample
    payee_name        payee.name
    payee_id          payee.id
    category_id       category.id
    department_id     department.id
    amount            Faker::Number.number(2)
    cleared           true
    uuid              Faker::Code.isbn

  end
end
