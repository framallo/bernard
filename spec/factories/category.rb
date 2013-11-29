require 'faker'

FactoryGirl.define do
  factory :category do
    name    Faker::Commerce.department
    deleted false
    pm_id                   (0..8).to_a.sample
    pm_type                 (0..2).to_a.sample
    budget_period           (100..1000).to_a.sample
    budget_limit            (50..500).to_a.sample
    include_subcategories   false
    rollover                false
    uuid                    Faker::Code.isbn
  end
end
